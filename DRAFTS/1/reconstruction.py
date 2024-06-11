#%% 
import open3d as o3d

#%%
import os
import time
import matplotlib
import numpy as np
matplotlib.use('TkAgg')
from matplotlib import pyplot as plt
from PIL import Image
import torch
from transformers import GLPNImageProcessor, GLPNForDepthEstimation

#%%
# Timing wrapper
def time_it(start_message, end_message):
    def decorator(func):
        def wrapper(*args, **kwargs):
            print(start_message)
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            print(f"{end_message}: {end_time - start_time:.2f} seconds")
            return result
        return wrapper
    return decorator

#%%
# Getting model
@time_it("Loading model...", "Model loaded")
def load_model():
    feature_extractor = GLPNImageProcessor.from_pretrained("vinvino02/glpn-nyu")
    model = GLPNForDepthEstimation.from_pretrained("vinvino02/glpn-nyu")
    return feature_extractor, model

feature_extractor, model = load_model()

#%%
# Load and resize images
IMAGE_SIZE = (512, 512)

@time_it("Loading images...", "Images loaded")
def load_images(image_dir):
    """Load and resize all the images from the given path."""
    images = []
    for filename in os.listdir(image_dir):
        filename = filename.lower()
        if filename.endswith(".jpg") or filename.endswith(".png"):
            img_path = os.path.join(image_dir, filename)
            img = Image.open(img_path).resize(IMAGE_SIZE)
            images.append(img)
    return images

images = load_images("images")

#%%
# Prepare the images for the model
@time_it("Preparing images for the model...", "Images prepared")
def prepare_images(images):
    return feature_extractor(images=images, return_tensors="pt")

input_images = prepare_images(images)

#%%
# Getting the depth map
@time_it("Estimating depth...", "Depth estimation completed")
def get_depth_map(input_images):
    with torch.no_grad():
        outputs = model(**input_images)
    return outputs.predicted_depth

predicted_depth = get_depth_map(input_images)

pad = 16

#%%
# Post processing each image with the predicted depths
@time_it("Post-processing images...", "Post-processing completed")
def post_process_images(images, predicted_depth, pad):
    depth_maps = []
    processed_images = []
    for i, img in enumerate(images):
        depth = predicted_depth[i].cpu().numpy() * 1000.0
        depth = depth[pad: -pad, pad: -pad]
        depth_maps.append(depth)
        
        img = img.crop((pad, pad, img.width - pad, img.height - pad))
        processed_images.append(img)
    return processed_images, depth_maps

processed_images, depth_maps = post_process_images(images, predicted_depth, pad)

#%%
# Prepare the depth images for the 3D reconstruction using open3d
@time_it("Creating RGBD images...", "RGBD images created")
def create_rgbd_images(processed_images, depth_maps):
    def create_rgbd_image(color_img, depth_img):
        color_o3d = o3d.geometry.Image(np.asarray(color_img))
        depth_o3d = o3d.geometry.Image((depth_img).astype(np.uint16))
        rgbd_image = o3d.geometry.RGBDImage.create_from_color_and_depth(color_o3d, depth_o3d, convert_rgb_to_intensity=False)
        return rgbd_image
    return [create_rgbd_image(img, depth) for img, depth in zip(processed_images, depth_maps)]

rgbd_images = create_rgbd_images(processed_images, depth_maps)

#%%
# Create a point cloud from multiple RGBD images
@time_it("Creating point clouds...", "Point clouds created")
def create_point_cloud(rgbd_images, intrinsic):
    pcds = []
    for rgbd in rgbd_images:
        pcd = o3d.geometry.PointCloud.create_from_rgbd_image(rgbd, intrinsic)
        pcds.append(pcd)
    return pcds

# Camera intrinsic parameters
intrinsic = o3d.camera.PinholeCameraIntrinsic()
intrinsic.set_intrinsics(width=IMAGE_SIZE[0], height=IMAGE_SIZE[1], fx=525.0, fy=525.0, cx=IMAGE_SIZE[0]//2, cy=IMAGE_SIZE[1]//2)

#%%
point_clouds = create_point_cloud(rgbd_images, intrinsic)

# Combine point clouds into a single point cloud
@time_it("Combining point clouds...", "Point clouds combined")
def combine_point_clouds(point_clouds):
    combined_pcd = o3d.geometry.PointCloud()
    for pcd in point_clouds:
        combined_pcd += pcd
    return combined_pcd

combined_pcd = combine_point_clouds(point_clouds)

#%%
# Downsample the combined point cloud for better visualization
@time_it("Downsampling point cloud...", "Point cloud downsampled")
def downsample_point_cloud(combined_pcd):
    return combined_pcd.voxel_down_sample(voxel_size=0.05)

downsampled_pcd = downsample_point_cloud(combined_pcd)


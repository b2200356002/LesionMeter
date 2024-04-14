import os
import boto3
from PIL import Image
import base64
import json
import io
import numpy as np

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # Extract data from the request body
    body = json.loads(event['body'])
    images = body['images']
    data = body['data']
    screen_size = data['screen_size']  # Screen size in inches
    resolution = data['resolution']  # Resolution in pixels (width x height)
    
    # Convert base64 images to PIL Image objects
    image_data = [base64_to_pil(img) for img in images]
    
    # Perform image blending
    blended_image = blend_images(image_data)
    
    # Perform image warping
    warped_image = warp_image(blended_image)
    
    # Perform image segmentation
    segmented_image = segment_lesion(warped_image)
    
    # Calculate surface area
    surface_area = calculate_surface_area(segmented_image, screen_size, resolution)
    
    # Upload images to S3
    upload_to_s3([blended_image, warped_image, segmented_image])
    
    # Return the surface area along with file paths of intermediate images
    return {
        "statusCode": 200,
        "body": json.dumps({
            "surface_area": surface_area,
        })
    }

def base64_to_pil(base64_string):
    # Decode base64 string and convert to PIL Image
    image_bytes = base64.b64decode(base64_string)
    image = Image.open(io.BytesIO(image_bytes))
    return image

def blend_images(images):
    # Perform blending of multiple images
    # This could involve techniques such as averaging, weighted averaging, or alpha blending
    blended_image = np.mean(images, axis=0).astype(np.uint8)
    return Image.fromarray(blended_image)

def warp_image(image):
    # Perform image warping to correct distortions or irregularities
    # This could involve geometric transformations such as rotation, scaling, or perspective correction
    # For simplicity, let's perform a basic transformation
    width, height = image.size
    warped_image = image.transform((width, height), Image.AFFINE, data=(1, 0, 100, 0, 1, 50))
    return warped_image

def segment_lesion(image):
    # Perform image segmentation to isolate the region of interest (e.g., skin lesion)
    # This could involve techniques such as thresholding, edge detection, or machine learning-based segmentation
    # For simplicity, let's perform basic thresholding
    gray_image = image.convert('L')
    threshold = 128
    segmented_image = gray_image.point(lambda p: 255 if p > threshold else 0)
    return segmented_image

def calculate_surface_area(image, screen_size, resolution):
    # Calculate surface area using the segmented image
    # This could involve counting pixels or using other morphological features
    # For simplicity, let's assume a basic calculation based on the number of non-zero pixels
    non_zero_pixels = np.count_nonzero(np.array(image))
    # Assuming the pixel size is 1x1 cm, calculate surface area in square centimeters
    width, height = map(int, resolution.split('x'))
    surface_area_cm2 = non_zero_pixels * (screen_size / width) * (screen_size / height)
    return surface_area_cm2

def upload_to_s3(images):
    # Upload images to S3 bucket
    bucket_name = os.environ.get('BUCKET_NAME')
    for i, image in enumerate(images):
        file_path = f"/tmp/image_{i}.jpg"
        image.save(file_path)
        file_name = os.path.basename(file_path)
        s3.upload_file(file_path, bucket_name, file_name)

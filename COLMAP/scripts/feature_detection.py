import cv2
import os
import pickle

# Path to the directory containing images
image_dir = '../images'
image_paths = [os.path.join(image_dir, fname) for fname in os.listdir(image_dir) 
               if (fname.endswith('.jpg') or fname.endswith('.png'))]

# Initialize SIFT detector
sift = cv2.SIFT_create()

# Function to detect and compute features
def detect_and_compute(image_path):
    image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    keypoints, descriptors = sift.detectAndCompute(image, None)
    keypoints = [(kp.pt, kp.size, kp.angle, kp.response, kp.octave, kp.class_id) for kp in keypoints]
    return keypoints, descriptors

# Detect features for all images
keypoints_list = []
descriptors_list = []
for image_path in image_paths:
    keypoints, descriptors = detect_and_compute(image_path)
    keypoints_list.append(keypoints)
    descriptors_list.append(descriptors)

# Save keypoints and descriptors for further processing
with open('../colmap_workspace/features.pkl', 'wb') as f:
    pickle.dump((keypoints_list, descriptors_list), f)

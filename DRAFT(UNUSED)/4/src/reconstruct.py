# src/reconstruct.py
import os
import cv2
import numpy as np
import open3d as o3d
from config import PROCESSED_DIR, INTRINSIC_CAMERA_MATRIX

def load_processed_images(image_dir=PROCESSED_DIR):
    images = []
    for filename in os.listdir(image_dir):
        if filename.startswith("processed_") and filename.endswith(".png"):
            img_path = os.path.join(image_dir, filename)
            img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
            images.append(img)
    return images

def detect_features(images):
    sift = cv2.SIFT_create()
    keypoints = []
    descriptors = []
    for img in images:
        kp, des = sift.detectAndCompute(img, None)
        keypoints.append(kp)
        descriptors.append(des)
    return keypoints, descriptors

def match_features(descriptors):
    bf = cv2.BFMatcher(cv2.NORM_L2, crossCheck=True)
    matches = []
    for i in range(len(descriptors) - 1):
        matches.append(bf.match(descriptors[i], descriptors[i+1]))
    return matches

def find_essential_matrix(kp1, kp2, matches, K):
    pts1 = np.float32([kp1[m.queryIdx].pt for m in matches])
    pts2 = np.float32([kp2[m.trainIdx].pt for m in matches])
    E, mask = cv2.findEssentialMat(pts1, pts2, K, method=cv2.RANSAC, prob=0.999, threshold=1.0)
    return E, mask

def recover_pose(E, kp1, kp2, matches, K):
    pts1 = np.float32([kp1[m.queryIdx].pt for m in matches])
    pts2 = np.float32([kp2[m.trainIdx].pt for m in matches])
    _, R, t, mask = cv2.recoverPose(E, pts1, pts2, K)
    return R, t, mask

def triangulate_points(kp1, kp2, matches, K, R, t):
    pts1 = np.float32([kp1[m.queryIdx].pt for m in matches])
    pts2 = np.float32([kp2[m.trainIdx].pt for m in matches])
    proj1 = np.hstack((np.eye(3), np.zeros((3, 1))))
    proj2 = np.hstack((R, t))
    proj1 = K @ proj1
    proj2 = K @ proj2
    points_4d_hom = cv2.triangulatePoints(proj1, proj2, pts1.T, pts2.T)
    points_3d = points_4d_hom[:3] / points_4d_hom[3]
    return points_3d.T

def reconstruct_3d(images, K):
    keypoints, descriptors = detect_features(images)
    matches = match_features(descriptors)
    
    all_points_3d = []
    for i in range(len(matches)):
        kp1, kp2 = keypoints[i], keypoints[i+1]
        E, mask = find_essential_matrix(kp1, kp2, matches[i], K)
        R, t, mask = recover_pose(E, kp1, kp2, matches[i], K)
        points_3d = triangulate_points(kp1, kp2, matches[i], K, R, t)
        all_points_3d.append(points_3d)
    
    all_points_3d = np.concatenate(all_points_3d, axis=0)
    pcd = o3d.geometry.PointCloud()
    pcd.points = o3d.utility.Vector3dVector(all_points_3d)
    return pcd

def save_point_cloud(pcd, filename="output.ply", output_dir=PROCESSED_DIR):
    output_path = os.path.join(output_dir, filename)
    o3d.io.write_point_cloud(output_path, pcd)

def visualize_point_cloud(pcd):
    o3d.visualization.draw_geometries([pcd])

def run_3d_reconstruction():
    K = INTRINSIC_CAMERA_MATRIX
    images = load_processed_images()
    pcd = reconstruct_3d(images, K)
    save_point_cloud(pcd)
    visualize_point_cloud(pcd)

if __name__ == "__main__":
    run_3d_reconstruction()

import cv2
import numpy as np

def reconstruct_images(image_paths):
    # Initialize SIFT detector
    sift = cv2.SIFT_create()

    # List to store keypoints and descriptors of all images
    keypoints_all = []
    descriptors_all = []

    # Read and process each image
    for file_path in image_paths:
        img = cv2.imread(file_path)

        # Check if the image was successfully read
        if img is None:
            raise ValueError(f"Image at path {file_path} could not be read.")

        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        keypoints, descriptors = sift.detectAndCompute(gray, None)
        keypoints_all.append(keypoints)
        descriptors_all.append(descriptors)

    # Camera calibration parameters - Assume known or estimated
    focal_length = 1.0  # Example value, replace with actual focal length of the camera
    principal_point = (0.5 * img.shape[1], 0.5 * img.shape[0])  # Image center as principal point
    camera_matrix = np.array([[focal_length, 0, principal_point[0]],
                              [0, focal_length, principal_point[1]],
                              [0, 0, 1]])

    # Storage for camera poses (extrinsic parameters)
    poses = [np.eye(4)]  # Assume first pose as the identity matrix

    # Feature Matching between each pair of images using FLANN or BFMatcher
    bf = cv2.BFMatcher()
    all_matches = []
    for i in range(len(descriptors_all) - 1):
        matches = bf.knnMatch(descriptors_all[i], descriptors_all[i + 1], k=2)
        # Apply Lowe's ratio test
        good = []
        for m, n in matches:
            if m.distance < 0.75 * n.distance:
                good.append(m)
        all_matches.append(good)

    point_cloud = []

    for i in range(len(all_matches)):
        good = all_matches[i]
        if len(good) > 8:  # Minimum number of points to find the fundamental matrix
            src_pts = np.float32([keypoints_all[i][m.queryIdx].pt for m in good]).reshape(-1, 1, 2)
            dst_pts = np.float32([keypoints_all[i + 1][m.trainIdx].pt for m in good]).reshape(-1, 1, 2)

            E, mask = cv2.findEssentialMat(src_pts, dst_pts, camera_matrix, method=cv2.RANSAC, prob=0.999, threshold=1.0)
            _, R, t, mask = cv2.recoverPose(E, src_pts, dst_pts, camera_matrix)

            # Construct the next pose
            pose = np.eye(4)
            pose[:3, :3] = R
            pose[:3, 3] = t.squeeze()
            poses.append(pose @ poses[-1])  # chain the previous pose with the new relative pose

            # Triangulate points
            projMatrix1 = camera_matrix.dot(np.hstack((poses[i][:3, :3], poses[i][:3, [3]])))
            projMatrix2 = camera_matrix.dot(np.hstack((poses[i + 1][:3, :3], poses[i + 1][:3, [3]])))
            points_3D_hom = cv2.triangulatePoints(projMatrix1, projMatrix2, src_pts, dst_pts)
            points_3D = cv2.convertPointsFromHomogeneous(points_3D_hom.T)
            point_cloud.append(points_3D.reshape(-1, 3))

    point_cloud = np.vstack(point_cloud)
    print("3D point cloud generated.")
    return point_cloud

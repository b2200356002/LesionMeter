# scripts/feature_matching.py
import cv2
import os
import pickle
from itertools import combinations

# Load keypoints and descriptors
with open('../colmap_workspace/features.pkl', 'rb') as f:
    keypoints_list, descriptors_list = pickle.load(f)

# Initialize the matcher
bf = cv2.BFMatcher()

# Function to match features between two images
def match_features(descriptors1, descriptors2):
    matches = bf.knnMatch(descriptors1, descriptors2, k=2)
    good_matches = []
    for m, n in matches:
        if m.distance < 0.75 * n.distance:
            good_matches.append(m)
    return good_matches

# Perform feature matching between all pairs of images
matches_dict = {}
for i, j in combinations(range(len(descriptors_list)), 2):
    matches = match_features(descriptors_list[i], descriptors_list[j])
    matches_dict[(i, j)] = matches

# Save matches for further processing
with open('../colmap_workspace/matches.pkl', 'wb') as f:
    pickle.dump(matches_dict, f)

import cv2
import numpy as np

# Load the unwrapped texture map
texture_map = cv2.imread("../results/uv_map.png", cv2.IMREAD_GRAYSCALE)

# Apply thresholding to segment the lesion
_, thresh = cv2.threshold(texture_map, 127, 255, cv2.THRESH_BINARY)
contours, _ = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

# Draw the contours on the image for visualization
contour_img = cv2.cvtColor(texture_map, cv2.COLOR_GRAY2BGR)
cv2.drawContours(contour_img, contours, -1, (0, 255, 0), 2)
cv2.imwrite("../results/segmented_lesion.png", contour_img)

# Calculate the area of the segmented lesion
area = cv2.contourArea(contours[0])
print(f"Area of the skin lesion: {area} pixels")

# Assuming a known scale factor (e.g., pixels per centimeter), convert to real-world units
scale_factor = 0.01  # Example scale factor
real_world_area = area * (scale_factor ** 2)
print(f"Real-world area of the skin lesion: {real_world_area} square centimeters")

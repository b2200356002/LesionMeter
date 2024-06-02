import cv2
import numpy as np
import matplotlib.pyplot as plt

# Load the image
image_path = "texture_0.png"
image = cv2.imread(image_path)
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Apply thresholding to segment the lesions
_, thresh = cv2.threshold(gray, 127, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

# Find contours of the lesions
contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Create a copy of the image to draw circles
output_image = image.copy()

# Iterate through contours and draw circles
lesion_areas = []
for contour in contours:
    if cv2.contourArea(contour) > 100:  # Filter small contours
        # Calculate the center and radius of the minimum enclosing circle
        (x, y), radius = cv2.minEnclosingCircle(contour)
        center = (int(x), int(y))
        radius = int(radius)
        
        # Draw the circle on the image
        cv2.circle(output_image, center, radius, (0, 255, 0), 2)
        
        # Calculate the area
        lesion_area = cv2.contourArea(contour)
        lesion_areas.append(lesion_area)

# Calculate total area of lesions
total_lesion_area = sum(lesion_areas)

# Display the output image
plt.figure(figsize=(10, 10))
plt.imshow(cv2.cvtColor(output_image, cv2.COLOR_BGR2RGB))
plt.title('Skin Lesions Highlighted')
plt.show()

# Print the total area of the lesions
print(f"Total area of skin lesions: {total_lesion_area} pixels")


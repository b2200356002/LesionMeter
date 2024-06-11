# src/analyze.py
import os
import cv2
import numpy as np
from config import OUTPUT_DIR as OUT

def load_projection(filename="projection.png", input_dir=OUT):
    input_path = os.path.join(input_dir, filename)
    img = cv2.imread(input_path, cv2.IMREAD_GRAYSCALE)
    return img

def detect_lesions(img):
    # Use adaptive thresholding for better results
    binary_img = cv2.adaptiveThreshold(img, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 11, 2)
    contours, _ = cv2.findContours(binary_img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    return contours

def calculate_area(contours):
    areas = [cv2.contourArea(contour) for contour in contours]
    total_area = sum(areas)
    return total_area

def save_detection_image(img, contours, filename="detection.png", output_dir=OUT):
    output_img = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
    cv2.drawContours(output_img, contours, -1, (0, 255, 0), 2)
    output_path = os.path.join(output_dir, filename)
    cv2.imwrite(output_path, output_img)

def run_analysis():
    img = load_projection()
    contours = detect_lesions(img)
    total_area = calculate_area(contours)
    save_detection_image(img, contours)
    return total_area

if __name__ == "__main__":
    area = run_analysis()
    print(f"Total lesion area: {area} square pixels")

# src/config.py
import os

import numpy as np

# Directory settings
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_DIR = os.path.join(BASE_DIR, 'data')
RAW_IMAGES_DIR = os.path.join(DATA_DIR, 'raw_images')
PROCESSED_DIR = os.path.join(DATA_DIR, 'processed')
OUTPUT_DIR = os.path.join(DATA_DIR, 'output')

# Image settings
IMAGE_SIZE = (512, 512)
INTRINSIC_CAMERA_MATRIX = np.array([[800, 0, 256], [0, 800, 256], [0, 0, 1]])  # Example values

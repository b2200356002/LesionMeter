# src/preprocess.py
import os
from PIL import Image, ImageOps
import numpy as np
from config import RAW_IMAGES_DIR, PROCESSED_DIR, IMAGE_SIZE

def load_images(image_dir=RAW_IMAGES_DIR):
    images = []
    for filename in os.listdir(image_dir):
        print(f"Loading image: {filename}")
        filename = filename.lower()
        if filename.endswith(".jpg") or filename.endswith(".png"):
            img_path = os.path.join(image_dir, filename)
            img = Image.open(img_path).resize(IMAGE_SIZE)
            images.append(np.array(img))
    return images

def save_processed_image(image, filename, output_dir=PROCESSED_DIR):
    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, filename)
    Image.fromarray(image).save(output_path)
    print(filename)

def preprocess_image(image):
    # Convert to grayscale
    gray_image = ImageOps.grayscale(Image.fromarray(image))
    # Normalize the image
    normalized_image = np.array(gray_image) / 255.0
    return (normalized_image * 255).astype(np.uint8)

def augment_image(image):
    # Example augmentation: Flip image horizontally
    augmented_image = ImageOps.mirror(Image.fromarray(image))
    return np.array(augmented_image)

def preprocess_images():
    images = load_images()
    for i, img in enumerate(images):
        processed_img = preprocess_image(img)
        augmented_img = augment_image(processed_img)
        print(f"Saving processed and augmented images for image {i}")
        save_processed_image(processed_img, f"processed_{i}.png")
        save_processed_image(augmented_img, f"augmented_{i}.png")

if __name__ == "__main__":
    preprocess_images() 
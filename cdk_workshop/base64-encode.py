from PIL import Image
import numpy as np
import base64
import json
import io

def lambda_handler(event, context):
    # Extract images from the request body
    body = json.loads(event['body'])
    images = body['images']
    
    # Convert base64 images to PIL Image objects
    image_data = [base64_to_pil(img) for img in images]
    
    # Perform image stitching
    stitched_image = stitch_images(image_data)
    
    # Perform image segmentation
    segmented_image = segment_lesion(stitched_image)
    
    # Calculate surface area
    surface_area = calculate_surface_area(segmented_image)
    
    # Return the surface area
    return {
        "statusCode": 200,
        "body": json.dumps({
            "surface_area": surface_area
        })
    }

def base64_to_pil(base64_string):
    # Decode base64 string and convert to PIL Image
    image_bytes = base64.b64decode(base64_string)
    print("1")
    image = io.BytesIO(image_bytes)
    print("2")
    image = Image.open(image)

    return image

def stitch_images(images):
    # Ensure all images have the same dimensions
    min_width = min(img.width for img in images)
    min_height = min(img.height for img in images)
    images = [img.crop((0, 0, min_width, min_height)) for img in images]
    
    # Create a new image to stitch onto
    stitched_image = Image.new('RGB', (min_width * len(images), min_height))
    
    # Paste each image onto the stitched image
    for i, img in enumerate(images):
        stitched_image.paste(img, (i * min_width, 0))
    
    return stitched_image

def segment_lesion(image):
    # Convert image to grayscale
    gray_image = image.convert('L')
    
    # Apply a threshold to segment the lesion
    threshold = 128  # Adjust as needed
    segmented_image = gray_image.point(lambda p: p > threshold and 255)
    
    return segmented_image

def calculate_surface_area(image):
    # Count the number of non-zero pixels
    non_zero_pixels = np.count_nonzero(np.array(image))
    
    # Assuming the pixel size is 1x1, the surface area is the count of non-zero pixels
    surface_area = non_zero_pixels
    
    return surface_area

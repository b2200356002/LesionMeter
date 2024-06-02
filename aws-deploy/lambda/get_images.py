import requests
import json

# Make a request to the Lambda function
lambda_url = 'https://8gwlbjz69j.execute-api.us-east-1.amazonaws.com/prod/skin-lesion'
response = requests.get(lambda_url)

# Check if the request was successful
if response.status_code == 200:
    # Parse the JSON response
    data = response.json()
    
    # Retrieve the file paths from the response
    original_image_paths = data['original_images']
    stitched_image_path = data['stitched_image']
    segmented_image_path = data['segmented_image']
    
    # Download the images
    for path in original_image_paths:
        image_response = requests.get(path)
        with open(f'original_image_{original_image_paths.index(path)}.jpg', 'wb') as f:
            f.write(image_response.content)
    
    stitched_image_response = requests.get(stitched_image_path)
    with open('stitched_image.jpg', 'wb') as f:
        f.write(stitched_image_response.content)
    
    segmented_image_response = requests.get(segmented_image_path)
    with open('segmented_image.jpg', 'wb') as f:
        f.write(segmented_image_response.content)
    
    print("Images downloaded successfully.")
else:
    print("Error:", response.status_code)

# import image from pil to open the image
from PIL import Image

def segment_lesion(image):
    # Perform image segmentation to isolate the region of interest (e.g., skin lesion)
    # Here, we segment the image using a simple thresholding method
    # if the rgb of the pixel is red or close to red then we consider it as a lesion 
    # and we will keep it in the segmented image else black
    segmented_image = Image.new("RGB", image.size)
    for x in range(image.width):
        for y in range(image.height):
            r, g, b = image.getpixel((x, y))
            if r > 120 and g < 100 and b < 100:
                segmented_image.putpixel((x, y), (r, g, b))
            else:
                segmented_image.putpixel((x, y), (0, 0, 0))
    
    # save the segmented image
    segmented_image.save("segmented_image.png")
    return segmented_image


# OPEN TEXTURE IMAGE
image = Image.open("texture_0.png")    
    
segment_lesion(image)
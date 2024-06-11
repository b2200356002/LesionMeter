# LesionMeter

**LesionMeter** is a mobile application designed to measure the area of skin lesions using images captured by mobile phones. This project aims to address the need for precise and efficient tools in dermatology for diagnosing, monitoring, and treating skin conditions.

## Key Features

- **2D to 3D Model Generation**: Converts 2D images into 3D models using photogrammetry techniques.
- **3D to 2D Unwrapping**: Unwraps 3D models to create 2D texture maps for further processing.
- **Preprocessing and Segmentation**: Utilizes advanced image segmentation models like the Segment Anything Model (SAM) combined with adaptive thresholding.
- **Area Calculation**: Calculates the area of the skin lesion from segmented images, providing accurate measurements in square centimeters.

## References

1. Schönberger, J. L., & Frahm, J.-M. (2016). Structure-from-Motion Revisited. In *Proc. IEEE Conf. on Computer Vision and Pattern Recognition (CVPR)*. Available: [COLMAP](https://colmap.github.io/)
2. ISIC Archive, International Skin Imaging Collaboration. Available: [ISIC Archive](https://www.isic-archive.com)
3. Meta AI. (2023). Segment Anything Model (SAM). Available: [Segment Anything](https://ai.facebook.com/research/publications/segment-anything/)
4. "Meshroom 2023.3.0 Documentation." Available: [Meshroom Documentation](https://meshroom-manual.readthedocs.io/en/latest/feature-documentation/core/pipelines/photogrammetry.html)

## About the Project

**LesionMeter** is a finishing project for the course BBM479/BBM480. It aims to enhance the accuracy and efficiency of skin lesion measurements in clinical settings. The project leverages advanced 3D reconstruction techniques and segmentation models to provide reliable measurements from mobile phone images.

### Future Work:

- Enhancing 3D model accuracy and computational efficiency.
- Expanding and diversifying datasets for improved model training.

## Backend

The backend of LesionMeter is responsible for handling the image processing, segmentation, and area calculation tasks. It is designed to be run on a server or a local machine, utilizing various libraries and tools to process the images captured by the mobile application.

### Requirements

To set up and run the backend, ensure you have the following installed:

- Python 3.8 or later
- Necessary Python libraries (see `requirements.txt`)
- GPU support for deep learning models (optional but recommended)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/LesionMeter.git
   cd LesionMeter´´´

   
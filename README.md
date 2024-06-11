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
- GPU support for deep learning models, segmentation models, image processing tasks (optional but recommended)

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/LesionMeter.git
   cd LesionMeter
    ```

2. **Install Dependencies**

   It is recommended to use a virtual environment to manage dependencies.

   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows use `venv\\Scripts\\activate`
   pip install -r requirements.txt (if it exists)
   ```

### Running the Notebooks

The backend functionalities are divided into several notebooks, each serving a specific purpose.

#### 1. 2D to 3D Model Generation and 3D to 2D Unwrapping

- Located in the `meshroom` folder.
- These notebooks utilize Meshroom for converting 2D images into 3D models and then unwrapping these 3D models to create 2D texture maps.
- **Usage**: Open the notebooks and update the input and output directories to your local paths for images and model files.

#### 2. Preprocessing and Segmentation

- Located in the `segmentation` folder.
- This folder contains notebooks for image preprocessing (contrast enhancement, noise removal, etc.) and advanced segmentation using models like SAM combined with adaptive thresholding.
- **Usage**: Open the notebooks and update the input and output directories to your local paths for images and processed files.

#### 3. Area Calculation

- Located in the `area_calculation` folder.
- These notebooks focus on calculating the area of skin lesions from the segmented images.
- **Usage**: Open the notebooks and update the input and output directories to your local paths for images and calculation results.

### Previous Trials

The project includes several folders containing previous implementation attempts and additional functionalities:

- **COLMAP Folder**: Contains implementation of 3D model generation using COLMAP.
- **FLASK Folder**: Implements the whole process within a Flask application for web deployment.
- **DRAFTS Folder**: Contains drafts and experimental approaches related to various aspects of the project.
- **aws_deploy Folder**: Includes a very basic segmentation model deployed on AWS.

Explore these folders to understand different aspects and the historical development of the project.

---

Feel free to explore each section and modify the input and output paths in the notebooks as needed for your specific use case.

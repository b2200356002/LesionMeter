import os
from flask import current_app
from werkzeug.utils import secure_filename
from .image_processing.reconstruction import reconstruct_images
from .image_processing.mesh_generation import generate_mesh
from .image_processing.flatten_mesh import flatten_mesh
from .image_processing.area_calculation import calculate_area
import numpy as np

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in current_app.config['ALLOWED_EXTENSIONS']

def handle_uploads(file_paths):
    # Ensure the output directory exists
    output_dir = "output"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Step 1: Reconstruct images into 3D model
    model_3d = reconstruct_images(file_paths)
    np.save(os.path.join(output_dir, "model_3d.npy"), model_3d)  # Save 3D model
    
    # Step 2: Generate mesh from the 3D model
    mesh_file_path = generate_mesh(model_3d)
    
    # Step 3: Flatten the mesh to a 2D surface
    flattened_surface, faces = flatten_mesh(mesh_file_path)
    np.save(os.path.join(output_dir, "flattened_surface.npy"), flattened_surface)  # Save flattened surface
    np.save(os.path.join(output_dir, "faces.npy"), faces)  # Save faces
    
    # Step 4: Calculate the surface area of the flattened surface
    area = calculate_area(flattened_surface, faces)
    
    return area

def upload_images(files):
    saved_files = []
    upload_folder = current_app.config['UPLOAD_FOLDER']
    
    # Ensure the upload folder exists
    if not os.path.exists(upload_folder):
        os.makedirs(upload_folder)
    
    for file in files:
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file_path = os.path.join(upload_folder, filename)
            file.save(file_path)
            saved_files.append(file_path)
    
    area = handle_uploads(saved_files)
    return area

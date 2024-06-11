# src/main.py
from preprocess import preprocess_images
from reconstruct import run_3d_reconstruction
from project_2d import run_projection
from analyze import run_analysis

if __name__ == "__main__":
    print("Starting the preprocessing step...")
    preprocess_images()
    print("Preprocessing complete.")
    
    print("Starting the 3D reconstruction step...")
    run_3d_reconstruction()
    print("3D reconstruction complete.")
    
    print("Starting the 2D projection step...")
    run_projection()
    print("2D projection complete.")
    
    print("Starting the lesion analysis step...")
    area = run_analysis()
    print(f"Lesion analysis complete. Total lesion area: {area} square pixels")

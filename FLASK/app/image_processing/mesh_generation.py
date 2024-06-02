import os
import numpy as np
from scipy.spatial import Delaunay
import trimesh
import time

def generate_mesh(point_cloud):
    # Ensure the point cloud is in a suitable numpy array format for Delaunay
    if point_cloud.shape[1] != 3:
        raise ValueError("Point cloud should have shape (n, 3)")

    # Compute Delaunay triangulation
    try:
        tri = Delaunay(point_cloud)
    except Exception as e:
        raise RuntimeError(f"Error during Delaunay triangulation: {e}")

    # Extract vertices and faces from Delaunay object
    vertices = point_cloud
    faces = tri.simplices

    # Create a mesh object using trimesh
    mesh = trimesh.Trimesh(vertices=vertices, faces=faces)

    # Clean the mesh to ensure it is edge-manifold
    mesh = mesh.process()

    # Fix normals
    mesh.fix_normals()

    # Fill holes to make the mesh watertight
    trimesh.repair.fill_holes(mesh)

    # Remove duplicate faces
    mesh.remove_duplicate_faces()

    # Additional mesh repairs
    trimesh.repair.fix_inversion(mesh)
    trimesh.repair.fill_holes(mesh)
    
    # Merge close vertices
    mesh.merge_vertices()

    # Check if the mesh is now watertight
    if not mesh.is_watertight:
        print("Warning: Generated mesh is not watertight, and may not be suitable for parameterization.")

    # Generate a meaningful file name
    timestamp = time.strftime("%Y%m%d-%H%M%S")
    mesh_file_name = f"mesh_{timestamp}.obj"
    output_dir = "meshes"
    os.makedirs(output_dir, exist_ok=True)
    mesh_file_path = os.path.join(output_dir, mesh_file_name)

    # Export the mesh to an OBJ file
    mesh.export(mesh_file_path, file_type='obj')

    print("Mesh generated and saved as", mesh_file_name)
    return mesh_file_path

# Example usage
# Assume `point_cloud_data` is your numpy array of shape (n, 3) with 3D coordinates
# path_to_mesh = generate_mesh(point_cloud_data)

import igl
import numpy as np

def flatten_mesh(mesh_file_path):
    """
    Load a 3D mesh from the specified file and flatten it into a 2D projection using harmonic parameterization with libigl.
    
    Args:
        mesh_file_path (str): Path to the file containing the 3D mesh.

    Returns:
        tuple: 2D coordinates of the mesh vertices after flattening and faces.
    """
    # Load the mesh directly with libigl
    v, f = igl.read_triangle_mesh(mesh_file_path)
    
    # Ensure the mesh is a manifold, suitable for parameterization
    if not igl.is_edge_manifold(f):
        print("Mesh must be edge-manifold for parameterization.")

    # Use libigl to perform harmonic parameterization
    bnd = igl.boundary_loop(f)
    bnd_uv = igl.map_vertices_to_circle(v, bnd)
    k = 1  # Harmonic order

    # Ensure bnd_uv has the correct number of boundary conditions
    assert bnd_uv.shape[0] == bnd.shape[0], "Boundary conditions must match the number of boundary vertices"

    uv = igl.harmonic(v, f, bnd, bnd_uv, k)

    # uv contains the 2D coordinates of the vertices after parameterization
    return uv, f

# Example usage
# Assume `mesh_file_path` is the path to your OBJ file generated from `generate_mesh`
# flattened_surface, faces = flatten_mesh(mesh_file_path)

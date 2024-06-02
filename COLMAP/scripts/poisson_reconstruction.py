# scripts/poisson_reconstruction.py
import open3d as o3d

# Load the dense point cloud from COLMAP
pcd = o3d.io.read_point_cloud("../colmap_workspace/dense/fused.ply")

# Perform Poisson surface reconstruction
mesh, densities = o3d.geometry.TriangleMesh.create_from_point_cloud_poisson(pcd, depth=9)

# Save the mesh
o3d.io.write_triangle_mesh("../results/lesion_mesh.ply", mesh)

# src/project_2d.py
import os
import numpy as np
import open3d as o3d
from config import OUTPUT_DIR as OUT, PROCESSED_DIR
import matplotlib.pyplot as plt

def load_point_cloud(filename="output.ply", input_dir=PROCESSED_DIR):
    input_path = os.path.join(input_dir, filename)
    pcd = o3d.io.read_point_cloud(input_path)
    return pcd

def project_to_2d(pcd):
    points = np.asarray(pcd.points)
    points_2d = points[:, :2]
    return points_2d

def save_projection(points_2d, filename="projection.png", output_dir=OUT):
    plt.figure(figsize=(10, 10))
    plt.scatter(points_2d[:, 0], points_2d[:, 1], s=1)
    plt.axis('equal')
    output_path = os.path.join(output_dir, filename)
    plt.savefig(output_path)
    plt.close()

def run_projection():
    pcd = load_point_cloud()
    points_2d = project_to_2d(pcd)
    save_projection(points_2d)

if __name__ == "__main__":
    run_projection()

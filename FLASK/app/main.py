import os
from flask import Blueprint, jsonify, render_template, request, send_file
from .image_upload import upload_images
import numpy as np
import matplotlib
matplotlib.use('Agg')  # Use Agg backend for non-interactive plotting
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

main = Blueprint('main', __name__)

@main.route('/')
def index():
    return render_template('upload.html')

@main.route('/upload-images', methods=['POST'])
def upload_images_route():
    files = request.files.getlist("files[]")
    area = upload_images(files)
    return jsonify({"area": area})

@main.route('/view')
def view():
    return render_template('view.html')

@main.route('/view-3d')
def view_3d():
    return render_template('view_3d.html')

@main.route('/download-3d-model')
def download_3d_model():
    output_dir = "output"
    mesh_file_path = os.path.join(output_dir, "mesh.obj")
    return send_file(mesh_file_path, as_attachment=True)

@main.route('/view-3d-model')
def view_3d_model():
    model_3d = np.load("output/model_3d.npy")
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(model_3d[:, 0], model_3d[:, 1], model_3d[:, 2])
    ax.set_title("3D Model")
    plt.savefig("output/3d_model.png")
    plt.close(fig)
    return send_file("output/3d_model.png", mimetype='image/png')

@main.route('/view-mesh')
def view_mesh():
    model_3d = np.load("output/model_3d.npy")
    faces = np.load("output/faces.npy")
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.plot_trisurf(model_3d[:, 0], model_3d[:, 1], model_3d[:, 2], triangles=faces, cmap='viridis')
    ax.set_title("Mesh")
    plt.savefig("output/mesh.png")
    plt.close(fig)
    return send_file("output/mesh.png", mimetype='image/png')

@main.route('/view-flattened-mesh')
def view_flattened_mesh():
    flattened_surface = np.load("output/flattened_surface.npy")
    faces = np.load("output/faces.npy")
    fig, ax = plt.subplots()
    ax.triplot(flattened_surface[:, 0], flattened_surface[:, 1], faces, color='blue')
    ax.set_title("Flattened Mesh")
    plt.savefig("output/flattened_mesh.png")
    plt.close(fig)
    return send_file("output/flattened_mesh.png", mimetype='image/png')

# scripts/uv_mapping.py
import bpy

# Load the mesh into Blender
bpy.ops.import_mesh.ply(filepath="../results/lesion_mesh.ply")

# Switch to Edit mode and unwrap the mesh
bpy.ops.object.mode_set(mode='EDIT')
bpy.ops.uv.unwrap(method='CONFORMAL')

# Save the UV map layout
bpy.ops.uv.export_layout(filepath="../results/uv_map.png", size=(2048, 2048))

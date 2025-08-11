extends Node3D

@export var grid_size: int = 10
@export var cell_size: float = 1.0
@export var line_color: Color = Color(1, 1, 1)

func _ready():
	var immediate_mesh = ImmediateMesh.new()
	var material = StandardMaterial3D.new()
	material.albedo_color = line_color
	print(material)
	#immediate_mesh.material_override = material

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	# Draw vertical lines (along Z)
	for x in range(grid_size + 1):
		var x_pos = x * cell_size
		immediate_mesh.surface_add_vertex(Vector3(x_pos, 0, 0))
		immediate_mesh.surface_add_vertex(Vector3(x_pos, 0, grid_size * cell_size))

	# Draw horizontal lines (along X)
	for z in range(grid_size + 1):
		var z_pos = z * cell_size
		immediate_mesh.surface_add_vertex(Vector3(0, 0, z_pos))
		immediate_mesh.surface_add_vertex(Vector3(grid_size * cell_size, 0, z_pos))

	immediate_mesh.surface_end()

	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = immediate_mesh
	add_child(mesh_instance)

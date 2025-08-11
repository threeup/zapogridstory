extends Node3D

func _ready():
	GlobalSignals.game_recenter.connect(_on_game_recenter)

func _on_game_recenter(x: float, z: float):
	var pos = Vector3.ZERO
	pos.x = round(x / 10.0) * 10.0
	pos.z = round(z / 10.0) * 10.0
	set_position(pos)
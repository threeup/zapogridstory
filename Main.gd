extends Node3D

@export var user_scene: PackedScene
@export var pawn_scene: PackedScene
@export var area_scene: PackedScene
@export var tile_scene: PackedScene

func _ready():
	GlobalPool.field = $Field
	GlobalPool.world = $World
	GlobalPool.userPrefab = user_scene
	GlobalPool.pawnPrefab = pawn_scene
	GlobalPool.areaPrefab = area_scene
	GlobalPool.tilePrefab = tile_scene

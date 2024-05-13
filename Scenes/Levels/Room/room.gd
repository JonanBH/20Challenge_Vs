extends Node2D
class_name Room

@export var target_camera : Camera2D

@onready var portals = $Portals
@onready var camera_2d = $Camera2D
@onready var tile_map = $TileMap
@onready var hazards = $Hazards

const SPIKE = preload("res://Scenes/Hazards/Spikes/spike.tscn")

func _ready():
	_place_spawnables()

func enable():
	PortalManager.change_camera_to(camera_2d)


func disable():
	pass


func _place_spawnables():
	var spawnables = tile_map.get_used_cells(1)
	
	for spawnable in spawnables:
		var atlas_coord = tile_map.get_cell_atlas_coords(1, spawnable)
		match atlas_coord:
			Vector2i(12, 0):
				var spike = SPIKE.instantiate()
				hazards.add_child(spike)
				spike.global_position = tile_map.map_to_local(spawnable) + position
			Vector2i(13, 0):
				var spike = SPIKE.instantiate()
				hazards.add_child(spike)
				spike.global_position = tile_map.map_to_local(spawnable) + position
				spike.rotation = deg_to_rad(90)
			Vector2i(12, 1):
				var spike = SPIKE.instantiate()
				hazards.add_child(spike)
				spike.global_position = tile_map.map_to_local(spawnable) + position
				spike.rotation = deg_to_rad(180)
			Vector2i(13, 1):
				var spike = SPIKE.instantiate()
				hazards.add_child(spike)
				spike.global_position = tile_map.map_to_local(spawnable) + position
				spike.rotation = deg_to_rad(-90)
	
	tile_map.set_layer_enabled(1, false)

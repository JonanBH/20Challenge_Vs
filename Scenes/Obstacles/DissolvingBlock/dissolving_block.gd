extends StaticBody2D

@export var _reset_on_player_leave : bool = true

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D


var is_dissolving : bool = false

func _ready():
	CheckpointManager.player_died.connect(reset)
	
	if _reset_on_player_leave:
		PortalManager.player_left_room.connect(reset)


func _on_player_detection_body_entered(body):
	if is_dissolving:
		return
	
	animated_sprite_2d.play("dissolve")
	is_dissolving = true


func _on_animated_sprite_2d_animation_finished():
	if is_dissolving == false:
		return
	
	collision_shape_2d.disabled = true
	animated_sprite_2d.hide()


func reset():
	is_dissolving = false
	collision_shape_2d.set_deferred("disabled", false)
	animated_sprite_2d.show()
	animated_sprite_2d.play("default")

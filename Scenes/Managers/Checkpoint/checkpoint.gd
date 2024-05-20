extends Area2D
class_name Checkpoint

@export var enabled_by_default := false
@export var is_upside_down := false
@export var room : Room

@onready var disabled_sprite = $DisabledSprite
@onready var enabled_sprite = $EnabledSprite


var is_enabled = false

func _ready():
	if enabled_by_default:
		enable()
	
	disabled_sprite.flip_v = is_upside_down
	enabled_sprite.flip_v = is_upside_down


func _on_body_entered(body):
	CheckpointManager.set_new_checkpoint(self)


func enable():
	if is_enabled:
		return
	
	disabled_sprite.hide()
	enabled_sprite.show()


func disable():
	if !is_enabled:
		return
	
	disabled_sprite.show()
	enabled_sprite.hide()

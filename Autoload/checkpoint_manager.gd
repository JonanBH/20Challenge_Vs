extends Node

signal player_died

var current_checkpoint : Checkpoint
var player : Player

func respawn():
	player.global_position = current_checkpoint.global_position
	player_died.emit()
	
	if current_checkpoint.is_upside_down:
		GravityManager.set_gravity(GravityManager.State.INVERTED)
	else:
		GravityManager.set_gravity(GravityManager.State.NORMAL)
	current_checkpoint.room.enable()


func set_new_checkpoint(target : Checkpoint):
	if current_checkpoint == target:
		return
	
	if current_checkpoint != null:
		current_checkpoint.disable()
	
	current_checkpoint = target
	current_checkpoint.enable()

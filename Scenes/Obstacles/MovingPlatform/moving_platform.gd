extends Path2D

enum CompletedBehaviour{
	RESPAWN,
	REVERSE
}

@export var SPEED : float = 100
@export var COMPLETE_BEHAVIOUR : CompletedBehaviour = CompletedBehaviour.REVERSE
@export var DELAY_TO_RESPAWN : float = 3.0
@export var DELAY_TO_REVERSE : float = 5.0

@onready var platform = $Platform
@onready var respawn_timer = $RespawnTimer
@onready var timer_to_change_direction = $TimerToChangeDirection


var direction : int = 1
var is_active : bool = true

func _ready():
	respawn_timer.wait_time = DELAY_TO_RESPAWN
	timer_to_change_direction.wait_time = DELAY_TO_REVERSE
	platform.progress = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_active:
		return

	platform.progress += SPEED * delta * direction
	
	if (direction == 1 and platform.progress_ratio >= 1.0) or (direction == -1 and platform.progress_ratio <= 0.0):
		is_active = false
		
		match COMPLETE_BEHAVIOUR:
			CompletedBehaviour.REVERSE:
				timer_to_change_direction.start()
			
			CompletedBehaviour.RESPAWN:
				respawn_timer.start()


func _on_timer_to_change_direction_timeout():
	direction *= -1
	is_active = true


func _on_respawn_timer_timeout():
	platform.progress = 0
	is_active = true

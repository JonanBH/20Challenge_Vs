extends Node

signal gravity_changed

enum State{
	NORMAL,
	INVERTED
}

var current_gravity_state : State = State.NORMAL

func get_gravity() -> Vector2: 
	var magnitude = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	match current_gravity_state:
		State.NORMAL:
			return ProjectSettings.get_setting("physics/2d/default_gravity_vector") * magnitude
		State.INVERTED:
			return -1 * ProjectSettings.get_setting("physics/2d/default_gravity_vector") * magnitude
		
	return Vector2.UP * magnitude

func toggle_gravity():
	if current_gravity_state == State.NORMAL:
		current_gravity_state = State.INVERTED
		gravity_changed.emit()
		return
	
	current_gravity_state = State.NORMAL
	gravity_changed.emit()


func set_gravity(new_state : State):
	var old_state = current_gravity_state
	current_gravity_state = new_state
	
	if old_state != current_gravity_state:
		gravity_changed.emit()

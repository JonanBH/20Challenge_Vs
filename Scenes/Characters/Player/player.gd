extends CharacterBody2D
class_name Player

@export var SPEED = 200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_alive := true

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var respawn_timer = $RespawnTimer


func _ready():
	CheckpointManager.player = self
	GravityManager.gravity_changed.connect(_update_sprite_horizontal_flip)


func _physics_process(delta):
	
	if !is_alive:
		return
	
	# Add the gravity.
	var gravity = GravityManager.get_gravity()
	if not is_on_floor():
		velocity += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("gravity_swap") and is_on_floor():
		GravityManager.toggle_gravity()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _update_sprite_horizontal_flip():
	sprite_2d.flip_v = GravityManager.current_gravity_state == GravityManager.State.INVERTED
	up_direction = (GravityManager.get_gravity()).normalized() * -1


func take_damage():
	is_alive = false
	animation_player.play("died")
	respawn_timer.start()


func _on_respawn_timer_timeout():
	# TODO : Respawn code
	is_alive = true
	CheckpointManager.respawn()

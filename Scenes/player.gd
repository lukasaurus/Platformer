extends CharacterBody2D


const SPEED = 300.0
@export var FRICTION = 20.0
@export var ACCELERATION = 15.0
const JUMP_VELOCITY = -350.0
@export var jumps = 1
enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT}
var anim_state = state.IDLE
@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var start_pos = global_position



func reset():
	global_position = start_pos
	set_physics_process(true)
	anim_state = state.IDLE
	animator.position = Vector2(0,-5)

func update_state():
	if anim_state == state.HURT:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDLE
		elif velocity.x != 0:
			anim_state = state.RUNNING
	else:
		if velocity.y < 0:
			anim_state = state.JUMPUP
		else:
			anim_state = state.JUMPDOWN
			

func update_animation(direction):
	if direction>0:
		animator.flip_h = false
	elif direction < 0:
		animator.flip_h = true
	
	match anim_state:
		state.IDLE:
			animation_player.play("idle")
		state.RUNNING:
			animation_player.play("run")
		state.JUMPUP:
			animation_player.play("jump_up")
		state.JUMPDOWN:
			animation_player.play("jump_down")
		state.HURT:
			animation_player.play("hurt")
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or jumps > 0):
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		
	if is_on_floor():
		jumps = 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	update_state()
	update_animation(direction)
	move_and_slide()
	
func enemy_checker(body):
	print(body.name)
	if body.is_in_group("Enemy") and velocity.y > 0:
		body.die()
		velocity.y = JUMP_VELOCITY
	elif body.is_in_group("Hurt"):
		anim_state = state.HURT

func _on_hit_box_area_entered(area):
	enemy_checker(area) # Replace with function body.


func _on_hit_box_body_entered(body):
	enemy_checker(body) # Replace with function body.

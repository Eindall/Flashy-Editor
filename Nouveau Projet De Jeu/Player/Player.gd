extends KinematicBody2D

const MOVE_SPEED = 400
const JUMP_FORCE = 1000
const MAX_FALL_SPEED = 1000
const GRAVITY = 60

enum Colors {PURPLE, PINK, BLUE}

var y_velocity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var move_dir = 0
	if Input.is_action_pressed("turn_purple"):
		$Sprite.modulate = Color("7e1ba2")
	if Input.is_action_pressed("turn_pink"):
		$Sprite.modulate = Color("1338b1")
	if Input.is_action_pressed("turn_blue"):
		$Sprite.modulate = Color("c302bc")
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
		
	# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velocity), Vector2(0, -1))
	
	var grounded = is_on_floor()
	var walljump = is_on_wall()
	y_velocity += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	if walljump and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	if grounded and y_velocity >= 0:
		y_velocity = 5
	if y_velocity > MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED
	

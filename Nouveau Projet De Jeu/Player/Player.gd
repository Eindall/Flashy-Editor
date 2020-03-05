extends KinematicBody2D

const MOVE_SPEED = 400
const JUMP_FORCE = 1000
const MAX_FALL_SPEED = 1000
const GRAVITY = 60

enum Colors {PURPLE, PINK, BLUE}

signal collided

var velocity = Vector2(0, 0)
var player_color = 'GREY'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	velocity.x = 0
	
	if Input.is_action_pressed("turn_purple") and player_color != 'PURPLE':
		$Sprite.modulate = Color("7e1ba2")
		player_color = 'PURPLE'
		set_collision(player_color)
	if Input.is_action_pressed("turn_blue") and player_color != 'BLUE':
		$Sprite.modulate = Color("1338b1")
		player_color = 'BLUE'
		set_collision(player_color)
	if Input.is_action_pressed("turn_pink") and player_color != 'PINK':
		$Sprite.modulate = Color("c302bc")
		player_color = 'PINK'
		set_collision(player_color)
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	velocity.x *= MOVE_SPEED
		
	var result = move_and_slide(velocity, Vector2(0, -1))
	velocity = result
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision and (collision.collider is TileMap):
			emit_signal('collided', collision.collider)
	
	var grounded = is_on_floor()
	var walljump = is_on_wall()
	velocity.y += GRAVITY
	if (grounded or walljump) and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_FORCE
	if grounded and velocity.y >= 0:
		velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED

func set_collision(color):
	self.set_collision_layer_bit(0, true)
	self.set_collision_layer_bit(1, true)
	self.set_collision_layer_bit(2, true)
	self.set_collision_layer_bit(3, true)
	self.set_collision_mask_bit(0, true)
	self.set_collision_mask_bit(1, true)
	self.set_collision_mask_bit(2, true)
	self.set_collision_mask_bit(3, true)
	if (color == 'PURPLE'):
		self.set_collision_layer_bit(1, false)
		self.set_collision_mask_bit(1, false)
	elif (color == 'PINK'):
		self.set_collision_layer_bit(2, false)
		self.set_collision_mask_bit(2, false)
	elif (color == 'BLUE'):
		self.set_collision_layer_bit(3, false)
		self.set_collision_mask_bit(3, false)

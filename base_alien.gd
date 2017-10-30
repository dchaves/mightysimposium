extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 2000
const SPEED = 50
const JUMP_SPEED = -1000
const NEAR_ZERO = 10

var acc = Vector2()
var vel = Vector2()

var movement = "stand"

# obtain the collsion node
onready var myfeet_col = get_node("myfeet")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	acc.y = GRAVITY

func _input(event):
	if event.is_action_pressed("ui_up") and myfeet_col.is_colliding():	
		vel.y = JUMP_SPEED
	
func _fixed_process(delta):
	var movement = "stand"
	
	vel.x = SPEED * (Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"))
	vel.y += acc.y * delta
	
	if (abs(vel.y) < NEAR_ZERO):
		vel.y = 0
		
	# move if you can, muahahah
	# motion returns the vector with the desired movement blocked by the collision
	var motion = move(vel * delta)
	
	if (self.is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		# force to collide with the platform
		vel = n.slide(vel)
		move(motion)
	
	# Set animation
	if ((vel.y != 0) and (not myfeet_col.is_colliding())):
		movement = "jump"
	elif (vel.x != 0):
		movement = "walk"
	
	# Set flip. If vel.x = 0, do not change
	if (vel.x < 0):
		self.get_node("Sprite").set_flip_h(true)
	if (vel.x > 0):
		self.get_node("Sprite").set_flip_h(false)
	self.get_node("Sprite").set_animation(movement)

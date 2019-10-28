extends Node2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const my_alien = "blue_alien"
var is_body_in = false

# obtain the area nodes
#onready var left_area = get_node("leftArea2D")
onready var right_area = get_node("rightArea2D")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#left_area.connect("body_enter", self, "_on_leftArea2D_body_enter")
	#left_area.connect("body_exit", self, "_on_leftArea2D_body_exit")
	right_area.connect("body_enter", self, "_on_rightArea2D_body_enter")
	right_area.connect("body_exit", self, "_on_rightArea2D_body_exit")
	is_body_in = false
	#set_fixed_process(true)

func _on_rightArea2D_body_enter(body):
	if(body.is_in_group(my_alien) and !is_body_in):
		is_body_in = true
		fade_out_alien(body)
	
func _on_rightArea2D_body_exit(body):
	is_body_in = false

func fade_out_alien(body):
	var sprite = body
	var fade_effect = body.get_node("fade_effect")
	body.set_script(null)
	body.get_node("collision").queue_free()
	body.get_node("player").queue_free()
	self.get_node("KinematicBody2D/AnimatedSprite").play("full")
	self.get_node("KinematicBody2D/AnimatedSprite").set_offset(Vector2(0,-28))
	fade_effect.start()
	get_node("/root/game_state").on_alien_goal(my_alien)

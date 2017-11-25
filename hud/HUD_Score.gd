extends Node2D

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	update_scores()

func set_number(alien, number):
	self.get_node(alien + "/Number_0").play(String(number % 10))
	self.get_node(alien + "/Number_1").play(String((number / 10) % 10))

func update_scores():
	set_number("blue_alien", get_node("/root/game_state").get_count("blue_alien"))
	set_number("red_alien", get_node("/root/game_state").get_count("red_alien"))
	set_number("green_alien", get_node("/root/game_state").get_count("green_alien"))
	set_number("grey_alien", get_node("/root/game_state").get_count("grey_alien"))
	set_number("yellow_alien", get_node("/root/game_state").get_count("yellow_alien"))
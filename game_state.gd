extends Node

var count = {
	"red_alien" : 0,
	"blue_alien" : 0,
	"green_alien" : 0,
	"grey_alien" : 0,
	"yellow_alien" : 0
}

var levels = [
	"title",
	"tutorial_0",
	"level_1",
	"the_end"
]

var thislevel = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func on_alien_goal(alien_type):
	count[alien_type] += 1
	
func get_count(alien_type):
	return count[alien_type]
	
func next_level(lastlevel):
	thislevel += 1
	lastlevel.get_tree().change_scene("res://levels/" + levels[thislevel] + ".tscn")
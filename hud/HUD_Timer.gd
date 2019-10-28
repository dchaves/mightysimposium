extends Node2D

const TOTAL_TIME = 10
var remaining_time

signal time_over

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("countdown").set_wait_time(1)
	get_node("countdown").start()
	get_node("countdown").set_one_shot(false)
	remaining_time = TOTAL_TIME
	_set_number(remaining_time)

func _on_countdown_timeout():
	remaining_time -= 1
	_set_number(remaining_time)
	if (remaining_time == 0):
		get_node("countdown").stop()
		emit_signal("time_over")

func _set_number(number):
	get_node("Numbers/Number_0").play(String(number % 10))
	get_node("Numbers/Number_1").play(String((number / 10) % 6))
	get_node("Numbers/Number_2").play(String((number / 60) % 10))
	get_node("Numbers/Number_3").play(String((number / 600) % 6))
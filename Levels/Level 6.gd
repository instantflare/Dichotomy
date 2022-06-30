extends Node2D

func _ready():
	get_node("Animation").animation = "Wake"
	get_node("Animation").frame = 1
	get_node("Timer").start()

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/End Screen.tscn")

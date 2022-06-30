extends Control

var pause_state = false
var cumu = 0

func ready():
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		pause()

func _process(delta: float) -> void:
	cumu += delta
	get_node("Light").set_position(Vector2(550 + (100*sin(cumu)), 100 + (20*cos(cumu)*cos(cumu))))
	get_node("CanvasModulate").set_position(Vector2((10*sin(cumu)), (20*cos(cumu/1.8)*cos(cumu/1.8))-25))
	get_node("CanvasModulate").rotation_degrees = sin(cumu/2.3)
	get_node("CanvasModulate").modulate = Color(1, 1, 1.25+(sin(cumu/1.3)/4))
	get_node("CanvasModulate").rotation_degrees = 1.5*sin(cumu/1.8)
	get_node("Resume").set_position(Vector2(450 + (5*sin(cumu)), 300 + (10*cos(cumu/1.5)*cos(cumu/1.5))))
	get_node("Menu").set_position(Vector2(450 - (4*sin(cumu)), 350 + (11*cos(cumu/1.2)*cos(cumu/1.2))))
	get_node("Quit").set_position(Vector2(450 + (6*sin(cumu)), 400 - (9*cos(cumu/1.4)*cos(cumu/1.4))))

func pause():
	pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state
	get_node("CanvasLayer/Background").visible = pause_state

func _on_Resume_pressed():
	pause()

func _on_Menu_pressed():
	pause()
	get_tree().change_scene("res://Levels/Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()

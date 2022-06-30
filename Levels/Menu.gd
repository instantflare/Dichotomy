extends Node2D
var cumu = 0

func _on_Button_button_down():
	get_tree().change_scene("res://Levels/Cut Scene.tscn")

func _process(delta: float) -> void:
	cumu += delta
	get_node("Light").set_position(Vector2(550 + (100*sin(cumu)), 100 + (20*cos(cumu)*cos(cumu))))
	get_node("CanvasModulate").set_position(Vector2((10*sin(cumu)), (20*cos(cumu/1.8)*cos(cumu/1.8))-25))
	get_node("CanvasModulate").rotation_degrees = sin(cumu/2.3)
	get_node("CanvasModulate").modulate = Color(1, 1, 1.25+(sin(cumu/1.3)/4))
	get_node("Button").set_position(Vector2(450 + (5*sin(cumu)), 300 + (10*cos(cumu/1.5)*cos(cumu/1.5))))
	get_node("CanvasModulate").rotation_degrees = 1.5*sin(cumu/1.8)
	get_node("Rules").set_position(Vector2(450 - (4*sin(cumu)), 350 + (11*cos(cumu/1.2)*cos(cumu/1.2))))
	get_node("Quit").set_position(Vector2(450 + (6*sin(cumu)), 400 - (9*cos(cumu/1.4)*cos(cumu/1.4))))

func _on_Quit_pressed():
	get_tree().quit()

func _on_Rules_pressed():
	get_node("Rules Panel").show()
	get_node("Light").hide()

func _on_Exit_pressed():
	get_node("Rules Panel").hide()
	get_node("Light").show()

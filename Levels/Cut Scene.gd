extends Node2D
var cumu = 0

func _process(_delta):
	cumu += 1
	if d(1):
		get_node("Animation").animation = "Eye"
		get_node("Animation").frame = 1
		get_node("Beep").play(77)
	if d(100):
		st("Where are you?")
	if d(250):
		st("Everything hurts.")
	if d(350):
		st("All you remember... is there was an accident")
	if d(500):
		st("You try to open your eyes but you can't seem to.")
		get_node("Label2").hide()
	if d(800):
		st("Your eyelids are so heavy.")
	if d(1000):
		st("You can hear a beeping.")
	if d(1300):
		st("Your control is being stripped away.")
	if d(1670):
		get_node("Animation").animation = "Black"
		get_node("Animation").frame = 1
	if d(1700):
		st("You feel yourself leave your body.")
	if d(2000):
		st("Your soul is going somewhere.")
	if d(2300):
		get_node("Animation").animation = "Wake"
		get_node("Animation").frame = 1
	if d(2350):
		st("But you feel stuck.")
	if d(2450):
		st("Between life and death")
	if d(2650):
		get_tree().change_scene("res://Levels/Level 1.tscn")

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().change_scene("res://Levels/Level 1.tscn")

func st(text):
	get_node("Label").text = text
func d(number):
	return(cumu == number)

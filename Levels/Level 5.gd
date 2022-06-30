extends Node2D
var cumu = 0
var temp = 0
var tick = 0

var rng = RandomNumberGenerator.new()

func _process(delta):
	cumu += delta
	tick += 1
	get_node("Background/ParallaxBackground").offset = Vector2(100*sin(cumu), 100*sin(cumu))
	if tick % int((50 + rng.randf_range(0, 5))) == 0:
		temp = tick + rng.randf_range(0, 10)
	if tick > temp:
		for i in range(1, 17):
			get_node("Background/ParallaxBackground/ParallaxLayer/" + str(i)).modulate = Color(1, 1, 1)
			get_node("Background/ParallaxBackground/ParallaxLayer/" + str(i)).rotation_degrees = 90
	else:
		for i in range(1, 17):
			get_node("Background/ParallaxBackground/ParallaxLayer/" + str(i)).modulate = Color(2, 2, 2)
			get_node("Background/ParallaxBackground/ParallaxLayer/" + str(i)).rotation_degrees = 0

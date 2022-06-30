extends Actor

#constants
var accel_speed = 100
var friction = 1.2
var jump_flexability = 8
var jump_var = 0
var air_resistance = 1.15
var death_time = 0.5
var timer = null
var wall_jump = Vector2(2000,-1500)
var respawn_point = Vector2(0, 0)

#variables
var mode = "W"
var antimode = "B"
var vx = 0
var can_dash = false
var level = 1

#temp
var temp = []

func _ready():
	temp = get_tree().current_scene.name.split(" ")
	level = int(temp[1])
	var portalnode = get_tree().get_root().find_node("Portal", true, false)
	portalnode.connect("level", self, "handlelevel")

func _physics_process(delta: float) -> void:
	switch()
	death()
	sound()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	var a = 1 if Input.is_action_pressed("move_right") else -1 if Input.is_action_pressed("move_left") else 0
	if Input.is_action_just_pressed("jump"):
		jump_var = jump_flexability
	jump_var -= 1 if jump_var > 0 else 0
	var c = -1.0 if jump_var > 0 and is_on_floor() else 1.0
	return Vector2(a, c)

func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, is_jump_interrupted: bool) -> Vector2:
	var out: = linear_velocity
	if is_on_floor() and level != 1:
		can_dash = true
	if is_on_wall() and Input.is_action_pressed("jump") and direction.x != 0 and level != 1:
		out.y = wall_jump.y
		for i in range(get_slide_count()):
			vx = get_slide_collision(i).normal.x * wall_jump.x
	vx = vx + direction.x * accel_speed
	vx = -speed.x if vx < -speed.x else speed.x if vx > speed.x else vx
	vx = vx/friction if is_on_floor() else vx/air_resistance
	if -50 < vx and vx< 50:
		vx = 0
	out.x = vx
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y -= -500
	return out

func death():
	temp = position[1]
	if temp >= 1000:
		get_tree().paused = true
		get_node("Death_Timer").wait_time = death_time
		get_node("Death_Timer").start()
		_velocity = Vector2()
		mode = "W"
	for i in range(get_slide_count()):
		if ("Tile " + antimode) in get_slide_collision(i).collider.name or "Enemy" in get_slide_collision(i).collider.name:
			get_tree().paused = true
			get_node("Death_Timer").wait_time = death_time
			get_node("Death_Timer").start()
			_velocity = Vector2()
			mode = "W"

func switch():
	if Input.is_action_just_pressed("switch") and level >= 3:
		mode = "W" if mode == "B" else "B" if mode == "W" else "W"
	antimode = "W" if mode == "B" else "B" if mode == "W" else "W"
	if mode == "B":
		get_node("Particles2D Black").set_emitting(true)
		get_node("Particles2D White").set_emitting(false)
		get_node("Background Black").set_emitting(true)
		get_node("Background White").set_emitting(false)
	else:
		get_node("Particles2D White").set_emitting(true)
		get_node("Particles2D Black").set_emitting(false)
		get_node("Background White").set_emitting(true)
		get_node("Background Black").set_emitting(false)

func sound():
	if is_on_floor() and _velocity[0] >= 200 or is_on_floor() and _velocity[0] <= -200:
		get_node("Slide Sound").stream_paused = false
	else:
		get_node("Slide Sound").stream_paused = true
	if Input.is_action_just_pressed("switch"):
		get_node("Switch Sound").play()

func _on_Timer_timeout():
	get_tree().paused = false
	position = respawn_point
	get_node("Particles2D Black").restart()
	get_node("Particles2D White").restart()

func handlelevel():
	level += 1
	get_tree().change_scene("res://Levels/Level " + str(level) + ".tscn")

extends Node2D
signal level


func _ready():
	pass

func _on_Portal_body_entered(body):
	emit_signal("level")

extends Sprite2D

var speed = 400
var angular_speed = PI


func _ready():
	var mytimer = get_node("MyTimer")
	mytimer.connect("timeout", _on_mytimer_timeout)

func _process(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta


func _on_button_pressed():
#	pass
	set_process(not is_processing() )


func _on_mytimer_timeout():
	visible = not visible

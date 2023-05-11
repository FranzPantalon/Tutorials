extends RigidBody2D

@export var minSpeed = 150.0	# px/s
@export var maxSpeed = 150.0	# px/s

func _ready():
	$AnimatedSprite2D.play()
	var mobTypes = $AnimatedSprite2D.sprite_frames.get_animation_names()
	randomize()
	$AnimatedSprite2D.animation = mobTypes[randi() % mobTypes.size()]
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()	# handles removing the mob at the end of the frame

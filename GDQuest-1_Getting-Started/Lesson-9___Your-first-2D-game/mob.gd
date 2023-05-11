extends RigidBody2D

@export var min_speed = 100.0	# px/s
@export var max_speed = 200.0	# px/s

func _ready():
	$AnimatedSprite2D.play()
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	randomize()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()	# handles removing the mob at the end of the frame

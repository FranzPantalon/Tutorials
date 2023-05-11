extends Area2D

signal hit

@export var speed = 400.0		# px/s
var screenSize = Vector2.ZERO


func _ready():
	hide()
	screenSize = get_viewport_rect().size


func _process(delta):
	
	var direction = Vector2.ZERO
	
	# Process keys
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	# Avoid having a vector of sqrt(2) if two keys are pressed simultaneously
	if direction.length() > 1:
		direction = direction.normalized()
	
	# Update character position
	position += direction * speed * delta
	
	# Clamp position to the game window's borders
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	
	# Set orientation of sprite, flip as applicable, and offset collision mask onto character's head
	if direction.x != 0:
		$AnimatedSprite2D.animation = "animHorizontal"
		$AnimatedSprite2D.flip_h = direction.x < 0
	elif  direction.y != 0:
		$AnimatedSprite2D.animation = "animVertical"
		if direction.y > 0:
			$AnimatedSprite2D.flip_v = true
			$AnimatedSprite2D.offset.y = -27
		else:
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.offset.y = 0
#	if direction.x < 0:
#		$AnimatedSprite2D.flip_h = true
#	else:
#		$AnimatedSprite2D.flip_h = false
#	if direction.y > 0:
#		$AnimatedSprite2D.flip_v = true
#	else:
#		$AnimatedSprite2D.flip_v = false
	
	# Play animations on moving
	if direction.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	

func start(newPosition):
	position = newPosition
	show()
	$CollisionShape2D.disabled = false		# no need to set_deferred, because no physical interaction happening at that moment

func _on_body_entered(body):
	hide()
#	$CollisionShape2D.disabled = true		# !!! Use set_deferred instead !!!
	$CollisionShape2D.set_deferred("disabled" , true)	# wait for end of the physics computation before disabling
	emit_signal("hit")

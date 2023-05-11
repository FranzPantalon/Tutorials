extends Node

@export var mob_scene : PackedScene
var score = 0



func _ready():
	randomize()
	


func new_game():
	score = 0
	$HUD.update_score(score)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	$Music.play()
	
	$StartTimer.start()
	
	$HUD.show_message("Get ready...")
	
	await $StartTimer.timeout
	$ScoreTimer.start()
	$SpawnTimer.start()


func game_over():
	$ScoreTimer.stop()
	$SpawnTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()


func _on_spawn_timer_timeout():
	
	# Randomize spawning location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()		#NOTE: randf() generates a random number between 0 and 1
	
	# Instanciate, add and place the new mob
	var mob_instance = mob_scene.instantiate()		# instanciate a mob
	add_child(mob_instance)		# add mob to the main
	mob_instance.position = mob_spawn_location.position	# place mob at spawning point
	
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI/4 , PI/4)
	mob_instance.rotation = direction
	
	var velocity = Vector2(randf_range(mob_instance.min_speed , mob_instance.max_speed) , 0)
	mob_instance.linear_velocity = velocity.rotated(direction)


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	


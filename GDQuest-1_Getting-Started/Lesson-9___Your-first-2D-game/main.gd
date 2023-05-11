extends Node

@export var mobScene : PackedScene
var score = 0



func _ready():
	randomize()
	


func newGame():
	score = 0
	$HUD.updateScore(score)
	
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	
	$Music.play()
	
	$StartTimer.start()
	
	$HUD.showMessage("Get ready...")
	
	await $StartTimer.timeout
	$ScoreTimer.start()
	$SpawnTimer.start()


func gameOver():
	$ScoreTimer.stop()
	$SpawnTimer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.showGameOver()


func _on_spawn_timer_timeout():
	
	# Randomize spawning location
	var mobSpawnLocation = $MobPath/MobSpawnLocation
	mobSpawnLocation.progress_ratio = randf()		#NOTE: randf() generates a random number between 0 and 1
	
	# Instanciate, add and place the new mob
	var mobInstance = mobScene.instantiate()		# instanciate a mob
	add_child(mobInstance)		# add mob to the main
	mobInstance.position = mobSpawnLocation.position	# place mob at spawning point
	
	var direction = mobSpawnLocation.rotation + PI / 2
	direction += randf_range(-PI/4 , PI/4)
	mobInstance.rotation = direction
	
	var velocity = Vector2(randf_range(mobInstance.minSpeed , mobInstance.maxSpeed) , 0)
	mobInstance.linear_velocity = velocity.rotated(direction)


func _on_score_timer_timeout():
	score += 1
	$HUD.updateScore(score)
	

extends CanvasLayer

signal start_game


func update_score(score):
	$ScoreLabel.text = str(score)


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$Countdown.start()


func show_game_over():
	show_message("GaMe OvEr")
	await $Countdown.timeout
	$MessageLabel.text = "DoDgE tHe CrEePs !"
	$MessageLabel.show()
	await get_tree().create_timer(1.0).timeout
	$Button.show()


func _on_button_pressed():
	$Button.hide()
	emit_signal("start_game")	


func _on_countdown_timeout():
	$MessageLabel.hide()

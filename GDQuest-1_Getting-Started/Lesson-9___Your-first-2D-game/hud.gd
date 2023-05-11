extends CanvasLayer

signal startGame


func updateScore(score):
	$ScoreLabel.text = str(score)


func showMessage(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$Countdown.start()


func showGameOver():
	showMessage("GaMe OvEr")
	await $Countdown.timeout
	$MessageLabel.text = "DoDgE tHe CrEePs !"
	$MessageLabel.show()
	await get_tree().create_timer(1.0).timeout
	$Button.show()


func _on_button_pressed():
	$Button.hide()
	emit_signal("startGame")	


func _on_countdown_timeout():
	$MessageLabel.hide()

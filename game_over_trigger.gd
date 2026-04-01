extends Area2D

#Im sorry i did it this way ;(
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.stop_overworld_music()
		$lose.play()
		body.active = false
		var cutscene_layer = get_tree().current_scene.get_node_or_null("Cutscene")
		if cutscene_layer:
			cutscene_layer.appear("Game Over!\n\nYou are now homeless ;(")
		$CollisionShape2D.set_deferred("disabled", true)

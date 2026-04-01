extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.stop_overworld_music()
		$Winj.play()
		body.active = false
		Global.cantEnd = true
		var cutscene_layer = get_tree().current_scene.get_node_or_null("Cutscene")
		if cutscene_layer:
			cutscene_layer.appear("Congratulations!\nOurple Guy is no longer homeless!\n\nThanks for playing! :)")
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(1.4).timeout
		$WinJmusic.play()

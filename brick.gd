extends StaticBody2D

func _on_bottom_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.velocity.y < 0:
			$BrickSound.play()
			
			visible = false
			$CollisionShape2D.set_deferred("disabled", true)
			$BottomDetector/CollisionShape2D.set_deferred("disabled", true)
			
			#wait for sound to finish
			await $BrickSound.finished
			queue_free()

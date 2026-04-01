extends Area2D

const HURT_SOUND = preload("res://Sounds/pipepowerdown.wav")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.lose_life()
		Global.play_hurt_sound(HURT_SOUND)
		get_tree().call_deferred("reload_current_scene")

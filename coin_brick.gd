extends StaticBody2D

var has_been_hit: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
func _on_bottom_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.velocity.y < 0 and !has_been_hit:
			Global.add_coin()
			$AnimatedSprite2D.play("empty")
			$CoinBlockSound.play()
			$CoinSound.play()
			bounce_block()
			has_been_hit = true
		elif body.velocity.y < 0 and has_been_hit:
			$CoinBlockSound.play()
			bounce_block()
			
func bounce_block() -> void:
	var tween = create_tween()
	var start_position = position
	var peak_position = start_position + Vector2(0, -10)
	#Move up
	tween.tween_property(self, "position", peak_position, 0.1).set_trans(Tween.TRANS_CIRC)
	#Move down
	tween.tween_property(self, "position", start_position, 0.1).set_trans(Tween.TRANS_CIRC)

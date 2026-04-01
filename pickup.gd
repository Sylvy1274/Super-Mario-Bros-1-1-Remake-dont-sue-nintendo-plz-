extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
func _on_body_entered(body):
	if body.name == "Player":
		Global.add_coin()
		$CoinGet.play()
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		
		#wait for sound to finish
		await $CoinGet.finished
		queue_free() # bye coin

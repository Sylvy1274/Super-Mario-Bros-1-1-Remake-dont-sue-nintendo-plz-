extends CharacterBody2D

const SPEED = 50.0
var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = true
const HURT_SOUND = preload("res://Sounds/pipepowerdown.wav")

@onready var ray_cast = $RayCast2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if can_move:
		if ray_cast.is_colliding():
				var collider = ray_cast.get_collider()
				
				if collider != null and collider.name != "Player":
					direction = -direction
					ray_cast.target_position.x = 20 * direction

		# Move the enemy
		velocity.x = direction * SPEED
		
		#Flip sprite
		if direction > 0:
			$AnimatedSprite2D.flip_h = true
		elif direction < 0:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = 0
		
	move_and_slide()

#goomba finally wins
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and can_move:
		Global.lose_life()
		Global.play_hurt_sound(HURT_SOUND)
		get_tree().call_deferred("reload_current_scene")


#dies
func _on_stomp_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and can_move:
		body.velocity.y = -250.0
		can_move = false
		$AnimatedSprite2D.play("die")
		$DamageGoomb.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()

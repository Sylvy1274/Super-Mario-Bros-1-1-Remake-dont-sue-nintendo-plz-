extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var active: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if active:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$JumpSound.play()

		# Get the input direction
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			
			#Flip Sprite
			if direction > 0:
				$AnimatedSprite2D.flip_h = false  # Facing right
			elif direction < 0:
				$AnimatedSprite2D.flip_h = true   # Facing left
				
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

	#Animation logic
	if not is_on_floor():
		$AnimatedSprite2D.play("Jump")
	else:
		if velocity.x != 0:
			$AnimatedSprite2D.play("Walk")
		else:
			$AnimatedSprite2D.play("Idle")

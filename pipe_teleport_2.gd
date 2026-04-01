extends Area2D

var player_inside: bool = false
var player_node: Node2D = null
var played: bool = false;

func _process(delta: float) -> void:
	if player_inside and player_node != null:
		if Input.is_action_pressed("ui_right"):
			if !played:
				$PipeSound.play()
			teleport_player()
			played = true;

func teleport_player() -> void:
	player_node.global_position = Vector2(2720, 20)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		player_node = body

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
		player_node = null

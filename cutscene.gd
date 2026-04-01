extends CanvasLayer

func _ready() -> void:
	$titlemusic.play()
	if not Global.cutscene_has_played:
		Global.cutscene_has_played = true
	else:
		hide()
		var player = get_tree().current_scene.get_node_or_null("Player")
		if player:
			player.active = true
	if Global.show_cover == false:
		get_node_or_null("Sprite2D").hide()
		get_node_or_null("Label2").hide()
		$titlemusic.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("end_cutscene") and !Global.cantEnd:
		if Global.show_cover:
			get_node_or_null("Sprite2D").hide()
			get_node_or_null("Label2").hide()
			Global.show_cover = false
			$confirmsound.play()
		else:
			disappear()
			$titlemusic.stop()
			$confirmsound.play()
			Global.cantEnd = true

#For intro
func disappear() -> void:
	hide()
	Global.play_overworld_music()
	var player = get_tree().current_scene.get_node_or_null("Player")
	if player:
		player.active = true

#For winning and losing
func appear(new_text: String) -> void:
	var label = get_node_or_null("Label")
	if label:
		label.text = new_text
	show()

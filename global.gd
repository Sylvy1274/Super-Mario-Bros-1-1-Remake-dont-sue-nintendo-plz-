extends Node

#allow for persistent music
@onready var sfx_player = AudioStreamPlayer.new()
@onready var music_player = AudioStreamPlayer.new()

var lives: int = 3
var coins: int = 0
var hud: CanvasLayer
var cutscene_has_played: bool = false
var cantEnd: bool = false
var show_cover: bool = true;

func _ready() -> void:
	add_child(sfx_player) 
	add_child(music_player)
	var track = load("res://Sounds/(01-41) Super Mario Bros. 1,2,VS.mp3")
	music_player.stream = track

func play_hurt_sound(sound_effect: AudioStream) -> void:
	sfx_player.stream = sound_effect
	sfx_player.play()

func add_coin():
	coins += 1
	if hud:
		hud.update_display(lives, coins)

func lose_life():
	lives -= 1
	coins = 0
	if hud:
		hud.update_display(lives, coins)
	if lives <= 0:
		cantEnd = true;
		var trigger = get_tree().current_scene.get_node_or_null("GameOverTrigger")
		if trigger:
			var collision_node = trigger.get_node_or_null("CollisionShape2D")
			if collision_node and collision_node.shape is RectangleShape2D:
				collision_node.shape.size *= 100.0
	

func play_overworld_music():
	music_player.volume_db = -5.0
	music_player.stream.loop = true
	music_player.play()

func stop_overworld_music():
	if music_player and music_player.is_playing():
		music_player.stop()

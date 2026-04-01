extends Node2D

@onready var hud = $HUD

func _ready() -> void:
	Global.hud = hud
	hud.update_display(Global.lives, Global.coins)

extends CanvasLayer

@onready var lives_label = $UI/VBoxContainer/LivesText
@onready var pickups_label = $UI/VBoxContainer/CoinsText

# Function to update the text from elsewhere in the game
func update_display(lives: int, coins: int) -> void:
	lives_label.text = "LIVES: " + str(lives)
	pickups_label.text = "COINS: " + str(coins)

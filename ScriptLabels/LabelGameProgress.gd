extends Label3D

func _ready():
	GlobalSignals.game_state_entered.connect(_on_game_state_entered)

func _on_game_state_entered(idx: int):
	self.text = "State" + str(idx)

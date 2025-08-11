extends Node

signal game_state_exited(lastState: int)
signal game_state_entered(nextState: int)
signal state_changed(machName: String, stateName: String)

signal spot_changed(spot: Vector2i)
signal game_recenter(x: float, y: float)

signal ui_refresh(delta: float)

var curspot := Vector2i(-99, -99)
var gameState := 0
var advancing := false
var uiElapsedTime := 0.0

#0 setup links
#1 make pools
#2 make user
#3 make pawn


func setGameState(state: int):
	if gameState != state:
		emit_signal("game_state_exited", gameState)
		gameState = state
		emit_signal("game_state_entered", gameState)

func advanceGameState():
	if advancing:
		return
	advancing = true
	await get_tree().create_timer(1.0).timeout
	advancing = false
	setGameState(gameState + 1)

func setSpot(spot: Vector2i):
	if spot != curspot:
		curspot = spot
		emit_signal("spot_changed", curspot)

func recenter(x: float, y: float):
	emit_signal("game_recenter", x, y)

func broadcastTransition(machName: String, stateName: String):
	emit_signal("state_changed", machName, stateName);
	self.uirefresh()

func uirefresh():
	emit_signal("ui_refresh", self.uiElapsedTime)
	self.uiElapsedTime = 0

func _process(delta: float) -> void:
	self.uiElapsedTime += delta

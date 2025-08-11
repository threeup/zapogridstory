class_name Boss
extends Node3D

@export var userCount: int
@export var curX: float
@export var curY: float

var existingAreas: Dictionary[Vector2i, Node] = {}
var allUsers: Array[User] = []


const StateBossNacent = preload("res://ScriptBoss/StateBossNacent.gd")
const StateBossPrepare = preload("res://ScriptBoss/StateBossPrepare.gd")
const StateBossReady = preload("res://ScriptBoss/StateBossReady.gd")
const StateBossActive = preload("res://ScriptBoss/StateBossActive.gd")

var machine := StateMachine.new()
var stateNacent := StateBossNacent.new()
var statePrepare := StateBossPrepare.new()
var stateReady := StateBossReady.new()
var stateActive := StateBossActive.new()


func _ready():
	machine.configure(self, "Boss");
	stateNacent.create(self, machine)
	statePrepare.create(self, machine)
	stateReady.create(self, machine)
	stateActive.create(self, machine)
	machine.initialize(stateNacent)
	machine.transitioned.connect(_on_machine_transitioned)
	GlobalSignals.advanceGameState()

func _on_machine_transitioned(machName: String, current: StateAbstract, _prev: StateAbstract):
	GlobalSignals.broadcastTransition(machName, current.getName())
		
func checkSpot():
	var roundedX = round(curX / 10.0)
	var roundedY = round(curY / 10.0)
	var spot = Vector2i(roundedX, roundedY)
	GlobalSignals.setSpot(spot)
	if !existingAreas.has(spot):
		existingAreas[spot] = initializeArea(spot)

func initializeArea(spot) -> Node:
	var pos = Vector3.ZERO
	pos.x = spot.x * 10
	pos.z = spot.y * 10
	return GlobalPool.genArea(pos)

func goPrepare():
	machine.changeState(statePrepare)

func goReady():
	machine.changeState(stateReady)

func goActive():
	machine.changeState(stateActive)

func _process(delta):
	machine.process(delta)

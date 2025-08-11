class_name User
extends Node

@export var speed: float = 8.0
@export var isLocal: bool = false


var pawn: Node = null;

const StateUserNacent = preload("res://ScriptUser/StateUserNacent.gd")
const StateUserPrepare = preload("res://ScriptUser/StateUserPrepare.gd")
const StateUserReady = preload("res://ScriptUser/StateUserReady.gd")
const StateUserActive = preload("res://ScriptUser/StateUserActive.gd")

var machine := StateMachine.new()
var stateNacent := StateUserNacent.new()
var statePrepare := StateUserPrepare.new()
var stateReady := StateUserReady.new()
var stateActive := StateUserActive.new()

func _ready() -> void:
	self.visible = false
	set_process(false)
	machine.configure(self, "U");
	stateNacent.create(self, machine)
	statePrepare.create(self, machine)
	stateReady.create(self, machine)
	stateActive.create(self, machine)
	machine.initialize(stateNacent)
	machine.transitioned.connect(_on_transitioned)
	
func _on_transitioned(machName: String, current: StateAbstract, _prev: StateAbstract):
	GlobalSignals.broadcastTransition(machName, current.getName())

func rename(nextname: String):
	self.name = nextname
	machine.totName = machine.getTotalName()

func assignPawn(nextPawn: Node):
	self.pawn = nextPawn

func getPawn() -> Node:
	return self.pawn

func isReady() -> bool:
	return machine.isState(stateReady)

func goNacent():
	set_process(false)
	machine.changeState(stateNacent)
	
func goPrepare():
	set_process(true)
	machine.changeState(statePrepare)

func goReady():
	machine.changeState(stateReady)

func goActive():
	machine.changeState(stateActive)


func localInput() -> Array:
	var pawnInput = Vector2.ZERO
	var hasInput = false
	if Input.is_action_pressed("north"):
		pawnInput.x = 1
		hasInput = true
	elif Input.is_action_pressed("south"):
		pawnInput.x = -1
		hasInput = true
	if Input.is_action_pressed("west"):
		pawnInput.y = 1
		hasInput = true
	elif Input.is_action_pressed("east"):
		pawnInput.y = -1
		hasInput = true
	return [pawnInput, hasInput]

func _physics_process(delta):
	machine.physics_process(delta)
	if pawn != null:
		var pawnInput = Vector2.ZERO
		var hasInput = false
		if isLocal:
			var inpval = localInput()
			pawnInput = inpval[0]
			hasInput = inpval[1]

		if hasInput:
			pawn.doMove(delta, speed, pawnInput.normalized())
		else:
			pawn.doMove(delta, 0.0, Vector2.ZERO)

func _process(delta):
	if machine.initState != null:
		machine.process(delta)
	# if isLocal:
	# 	if pawn != null && Input.is_action_pressed("recenter"):
	# 		GlobalSignals.recenter(pawn.pos.x, pawn.pos.z)

class_name Pawn
extends RigidBody3D

@export var pawnspeed: float = 8.0

var pos := Vector3.ZERO;
var timeAlive := 0.0

const StatePawnNacent = preload("res://ScriptPawn/StatePawnNacent.gd")
const StatePawnPrepare = preload("res://ScriptPawn/StatePawnPrepare.gd")
const StatePawnReady = preload("res://ScriptPawn/StatePawnReady.gd")
const StatePawnActive = preload("res://ScriptPawn/StatePawnActive.gd")

var machine := StateMachine.new()
var stateNacent := StatePawnNacent.new()
var statePrepare := StatePawnPrepare.new()
var stateReady := StatePawnReady.new()
var stateActive := StatePawnActive.new()

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

func doMove(deltaTime: float, speed: float, deltaInput: Vector2):
	pos.x += deltaTime * speed * deltaInput.x
	pos.z += deltaTime * speed * deltaInput.y
	PhysicsServer3D.body_set_state(
		get_rid(),
		PhysicsServer3D.BODY_STATE_TRANSFORM,
		Transform3D.IDENTITY.translated(pos)
	)

func _process(delta: float) -> void:
	timeAlive += delta
	if machine.initState != null:
		machine.process(delta)

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
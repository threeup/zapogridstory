extends Object

class_name StateAbstract

var ownerNode: Node
var machine: Object
var stateName: String

func create(owner: Node, state_machine: Object) -> void:
	self.ownerNode = owner
	self.machine = state_machine
	self.setName()

func transition_to(state: StateAbstract) -> void:
	self.machine.transition_to(state)

func getName() -> String:
	return self.stateName

func setName() -> void:
	self.stateName = "Undefined"

func canEnter(_curr: StateAbstract) -> bool:
	return true

func canExit(_next: StateAbstract) -> bool:
	return true

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(_event: InputEvent) -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func integrate_forces(_state: Object) -> void:
	pass
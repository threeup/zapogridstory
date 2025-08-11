class_name StateBossAbstract
extends StateAbstract

var timeInState: float = 0.0
var ownerBoss: Boss = null

func create(owner: Node, state_machine: Object) -> void:
	super (owner, state_machine)
	self.ownerBoss = owner as Boss

func enter() -> void:
	timeInState = 0.0
	
func process(delta: float) -> void:
	timeInState += delta

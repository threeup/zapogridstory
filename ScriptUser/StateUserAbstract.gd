class_name StateUserAbstract
extends StateAbstract

var timeInState: float = 0.0
var ownerUser: User = null

func create(owner: Node, state_machine: Object) -> void:
	super (owner, state_machine)
	self.ownerUser = owner as User

func enter() -> void:
	timeInState = 0.0
    
func process(delta: float) -> void:
	timeInState += delta
class_name StatePawnAbstract
extends StateAbstract

var timeInState: float = 0.0
var ownerPawn: Pawn = null

func create(owner: Node, state_machine: Object) -> void:
	super (owner, state_machine)
	self.ownerPawn = owner as Pawn
    
func enter() -> void:
	timeInState = 0.0
    
func process(delta: float) -> void:
	timeInState += delta
extends StateAbstract

class_name StateNoop

var timeInState: float = 0.0

func setName() -> void:
	self.stateName = "Noop"

func enter() -> void:
	timeInState = 0.0

func process(delta: float) -> void:
	timeInState += delta
	pass
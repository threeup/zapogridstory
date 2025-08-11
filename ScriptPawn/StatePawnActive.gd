extends StatePawnAbstract

func setName() -> void:
	self.stateName = "Active"

func process(delta: float) -> void:
	super (delta)
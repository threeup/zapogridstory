extends StatePawnAbstract

func setName() -> void:
	self.stateName = "Prepare"

func process(delta: float) -> void:
	super (delta)
	if timeInState < 0.7:
		return
	self.ownerPawn.goReady()
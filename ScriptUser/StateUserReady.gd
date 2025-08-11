extends StateUserAbstract

func setName() -> void:
	self.stateName = "Ready"

func process(delta: float) -> void:
	super (delta)
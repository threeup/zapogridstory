extends StateUserAbstract

func setName() -> void:
	self.stateName = "Active"

func enter() -> void:
	super ()
	assert(self.ownerUser)
	
	var ownerPawn: Node = self.ownerUser.getPawn()
	assert(ownerPawn)
	ownerPawn.goActive()

func process(delta: float) -> void:
	super (delta)
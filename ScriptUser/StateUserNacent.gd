extends StateUserAbstract

func setName() -> void:
	self.stateName = "Nacent"

func enter() -> void:
	super ()
	assert(self.ownerUser)
	
	var ownerPawn: Node = self.ownerUser.getPawn()
	if ownerPawn != null:
		GlobalPool.freePawn(ownerPawn)
		self.ownerUser.assignPawn(null)

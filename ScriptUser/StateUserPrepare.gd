extends StateUserAbstract

func setName() -> void:
	self.stateName = "Prepare"

func enter() -> void:
	super ()
	assert(self.ownerUser)

	var pawn = GlobalPool.genPawn(Vector3.ZERO)
	self.ownerUser.assignPawn(pawn)
	pawn.goPrepare()

func process(delta: float) -> void:
	super (delta)
	assert(self.ownerUser)

	var ownerPawn: Node = self.ownerUser.getPawn()
	if ownerPawn != null && ownerPawn.isReady():
		self.ownerUser.goReady()

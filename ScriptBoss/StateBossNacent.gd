extends StateBossAbstract

func setName() -> void:
	self.stateName = "Nacent"

func enter() -> void:
	super ()
	assert(self.ownerBoss)
	
	if len(self.ownerBoss.allUsers) > 0:
		for user in self.ownerBoss.allUsers:
			user.queue_free()
		self.ownerBoss.allUsers.clear()

func process(delta: float) -> void:
	super (delta)
	if timeInState < 0.5:
		return
	if Input.is_action_pressed("recenter"):
		self.ownerBoss.goPrepare()
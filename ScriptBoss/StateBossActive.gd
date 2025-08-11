extends StateBossAbstract

func setName() -> void:
	self.stateName = "Active"

func enter() -> void:
	super ()
	assert(self.ownerBoss)
	
	for user in self.ownerBoss.allUsers:
		user.goActive()

func process(delta: float) -> void:
	super (delta)
	
	if Input.is_action_pressed("recenter"):
		GlobalSignals.uirefresh()
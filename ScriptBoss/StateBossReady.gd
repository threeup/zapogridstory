extends StateBossAbstract

func setName() -> void:
	self.stateName = "Ready"
        
func enter() -> void:
	super ()
	
func process(delta: float) -> void:
	super (delta)
	assert(self.ownerBoss)
	
	if timeInState < 0.5:
		return
	
	if Input.is_action_pressed("recenter"):
		self.ownerBoss.goActive()
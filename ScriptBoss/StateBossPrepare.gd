extends StateBossAbstract

func setName() -> void:
	self.stateName = "Prepare"

func enter() -> void:
	super ()
	assert(self.ownerBoss)
	
	for i in range(self.ownerBoss.userCount):
		var nextUser = GlobalPool.genUser(Vector3.ZERO)
		if i == 0:
			nextUser.isLocal = true
			nextUser.rename("UserLocal" + str(i))
		else:
			nextUser.isLocal = false
			nextUser.rename("UserRemote" + str(i))
		self.ownerBoss.allUsers.append(nextUser)
	
	for user in self.ownerBoss.allUsers:
		user.goPrepare()
		

func process(delta: float) -> void:
	super (delta)

	var userTotal: int = len(self.ownerBoss.allUsers)
	var userReady: int = 0
	for i in range(userTotal):
		var owner: User = self.ownerBoss.allUsers[i] as User
		if owner.isReady():
			userReady += 1
	
	if userTotal == userReady:
		self.ownerBoss.goReady()
extends Object

class_name StateMachine

signal transitioned(name: String, current: StateAbstract, prev: StateAbstract)

var ownerNode: Node
var machineName: String
var totName: String

var initState: StateAbstract
var prev: StateAbstract
var curr: StateAbstract

var shouldPrintDebug: bool

func configure(owner: Node, name: String) -> void:
	self.ownerNode = owner
	self.machineName = name
	self.totName = self.getTotalName()
	self.shouldPrintDebug = false

func initialize(state: Object) -> void:
	self.initState = state
	self.prev = state
	self.curr = state
	self.initState.enter()

func transitionDebugEnable() -> void:
	self.shouldPrintDebug = true

func transitionDebugDisable() -> void:
	self.shouldPrintDebug = false

func printDebugReport() -> void:
	print("{totname} {prev_state} -> {next_state} ".format(
				{
					"totname": self.totName,
					"prev_state": self.prev.get_name(),
					"next_state": self.curr.get_name()
				}))

func getTotalName() -> String:
	return "[{owner}|{sm}]".format(
				{
					"owner": self.ownerNode.name,
					"sm": self.machineName,
					});

func getCurr() -> Object:
	return self.curr

func getPrev() -> Object:
	return self.prev

func isState(state: Object) -> bool:
	return state == self.curr

func changeState(state: Object) -> void:
	if state == null:
		print("bad input change")
		return
	if self.curr == null:
		print("not initialized")
		return
	if state == self.curr:
		print("same state")
		return
	if !self.curr.canExit(state):
		print("cant exit")
		return
	if !state.canEnter(self.curr):
		print("cant enter")
		return

	self.prev = curr
	self.prev.exit()

	self.curr = state
	emit_signal("transitioned", self.totName, self.curr, self.prev)
	self.curr.enter()

	if self.shouldPrintDebug:
		self.printDebugReport()


func input(event: InputEvent) -> void:
	if self.curr == null:
		return
	self.curr.input(event)

func process(delta: float) -> void:
	if self.curr == null:
		print("no curr process " + self.totName + "," + self.ownerNode.name)
		return
	self.curr.process(delta)

func physics_process(delta: float) -> void:
	if self.curr == null:
		return
	self.curr.physics_process(delta)

func integrate_forces(state: Object) -> void:
	if self.curr == null:
		return
	self.curr.integrate_forces(state)

extends Label3D

var activeDict = {
	"a": "b"
}

var ttlDict = {"a": 3}

func _ready():
	GlobalSignals.state_changed.connect(_on_state_changed)
	GlobalSignals.ui_refresh.connect(_on_ui_refresh)

func _on_state_changed(machName: String, stateName: String):
	self.activeDict[machName] = stateName
	self.ttlDict[machName] = 30

func _on_ui_refresh(delta: float) -> void:
	var keys_to_remove := []

	for machName in self.ttlDict.keys():
		ttlDict[machName] -= delta
		if ttlDict[machName] <= 0.0:
			keys_to_remove.append(machName)

	for machName in keys_to_remove:
		self.activeDict.erase(machName)
		self.ttlDict.erase(machName)
	
	self.makeString()

func makeString() -> void:
	var tx := ""
	for key in self.activeDict.keys():
		tx += "%s: %s\n" % [key, self.activeDict[key]]
	self.text = tx

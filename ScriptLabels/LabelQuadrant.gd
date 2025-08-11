extends Label3D

func _ready():
	GlobalSignals.spot_changed.connect(_on_spot_changed)

func _on_spot_changed(newpos: Vector2i):
	self.text = str(newpos)

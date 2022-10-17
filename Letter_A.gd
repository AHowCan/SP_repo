extends Sprite


signal instance_instantiated

func _ready():
	self.connect("instance_instantiated", get_parent(), "instance_instantiated")
	emit_signal("instance_instantiated")

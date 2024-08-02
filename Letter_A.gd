extends Sprite2D


signal instance_instantiated

func _ready():
	self.connect("instance_instantiated", Callable(get_parent(), "instance_instantiated"))
	emit_signal("instance_instantiated")

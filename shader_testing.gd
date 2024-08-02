extends Sprite2D

@onready var selfnode = $"."

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var blue_value = 0.0
var timer = 0.0
#self.material.set_shader_param("blue", blue_value)
#onready var bluesss = material.set_shader_param("blue", blue_value)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func _process(delta: float) -> void:
	timer += delta
	if timer >= 5 and timer < 6:
		material.set_shader_parameter("active", true)
	else:
		material.set_shader_parameter("active", false)

		
		
	
#material.set_shader_param("blue", blue_value)
#selfnode.material.set_shader_param("blue", blue_value)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Node2D

var word_coordinate_positions = [
	Vector2(150,150)
]

onready var word_coordinate_controller = $CoordinateController
onready var coordinate_locations = $C_Locations

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in coordinate_locations.get_children():
		word_coordinate_controller.create_word_coordinate(
			i.position)
		
		#word_coordinate_controller.create_word_coordinate(
			#word_coordinate_positions[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

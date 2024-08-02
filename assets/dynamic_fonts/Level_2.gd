extends Node2D

@onready var word_coordinate_controller = $CoordinateController
@onready var coordinate_locations = $C_Locations
@onready var player = $UI_Player/Player

var word_list

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in coordinate_locations.get_children():
		word_coordinate_controller.create_word_coordinate(i.position)
		player.word_location[word_coordinate_controller.word_list[-1]] = i.position
	player.wordList = word_coordinate_controller.word_list


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

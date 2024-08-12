extends Node2D

@onready var word_coordinate_controller = $CoordinateController
@onready var coordinate_locations = $C_Locations
@onready var madlib_controller = $Madlib_controller
@onready var player = $UI_Player/Player

var word_list
var current_word = []
var old_word = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in coordinate_locations.get_children():
		word_coordinate_controller.create_word_coordinate(i.position)
		player.word_location[word_coordinate_controller.word_list[-1]] = i.position
	player.wordList = word_coordinate_controller.word_list
	player.connect("updateTypingWord", _on_Player_updateTypingWord)

func _on_Player_updateTypingWord(word):
	current_word = "".join(word)
	madlib_controller.check_type_matches_ml_word(current_word)

func _process(delta):
	pass

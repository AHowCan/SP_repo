extends Node2D

var word_coordinate_list = []
var word_coordinate_positions = []
var letter_scene = preload("res://src/Word_Coordinate.tscn")

func _ready():
	pass

func create_word_coordinate(location:Vector2, word:String=""):
	if word == "":
		word = random_word()
		
	var instance = letter_scene.instance()
	add_child(instance)
	
	instance.create_word_coordinate(word)
	instance.set_position(location)
	
	#word_coordinate_positions.append(location)
	word_coordinate_list.append(instance)

func random_word() -> String:
	randomize()
	var index = randi() % len(words) + 1
	return words[index]

var words = {
	1 : "rock",
	2 : "light",
	3 : "laser",
	4 : "bomb",
	5 : "dust",
	6 : "word",
	7 : "spike",
	8 : "space",
	9 : "disc",
	10: "blob",
	11: "star",
	12: "fly",
	13: "bound",
	14: "fin",
	15: "begin",
	16: "lock",
	17: "kick",
	18: "twamp",
	19: "air",
	20: "empty",
	21: "orbit",
	22: "hole",
	23: "wax",
	24: "wane",
	25: "ring"
}

var word_used = { 
	1:0,
	2:0,
	3:0,
	4:0,
	5:0,
	6:0,
	7:0,
	8:0,
	9:0,
	10:0,
	11:0,
	12:0,
	13:0,
	14:0,
	15:0,
	16:0,
	17:0,
	18:0,
	19:0,
	20:0,
	21:0,
	22:0,
	23:0,
	24:0,
	25:0
}

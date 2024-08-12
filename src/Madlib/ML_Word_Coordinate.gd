extends Node2D

@onready var letters = $letters
@onready var letter_list = letters.get_children()
#@onready var backgrounds = $backgrounds

var max_word_length = 8
#@onready var background_list = backgrounds.get_children()

var letter_count 
var word


func create_word_coordinate(use_word: String):
	word = use_word
	letter_count = len(word)
	for i in range(max_word_length):
		if i < len(word):
			letter_list[i].text = word[i]
		else:
			letter_list[i].visible = false
			#background_list[i].visible = false
	
func set_pos(pos:Vector2):
	self.position.x = pos[0]
	self.position.y = pos[1]



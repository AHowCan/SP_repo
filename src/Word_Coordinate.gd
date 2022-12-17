extends Node2D

onready var letters = $letters

var max_word_length = 5
onready var letter_list = letters.get_children()

onready var letter1 = $letters/Letter1
onready var letter2 = $letters/Letter2
onready var letter3 = $letters/Letter3
onready var letter4 = $letters/Letter4
onready var letter5 = $letters/Letter5


var letter_count 
var word


func create_word_coordinate(use_word: String):
	word = use_word
	letter_count = len(word)
	for i in range(5):
		if i < len(word):
			letter_list[i].text = word[i]
		else:
			letter_list[i].visible = false
	
func set_position(pos:Vector2):
	self.position.x = pos[0]
	self.position.y = pos[1]



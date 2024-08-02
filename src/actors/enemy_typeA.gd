extends Node2D

@onready var letter1 = $L1
@onready var letter2 = $L2
@onready var letter3 = $L3
@onready var letter4 = $L4
@onready var letter5 = $L5

const letter_width = 15
const letter_scale = 0.6
const spacing = 1 * letter_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display_word(word: String):
	
	if len(word) == 3:
		letter1.visible = false
		letter5.visible = false
		letter2.set_position(Vector2(-letter_width*1*spacing,0))
		letter3.set_position(Vector2(letter_width*0*spacing,0))
		letter4.set_position(Vector2(letter_width*1*spacing,0))
		letter2.text = word[0]
		letter3.text = word[1]
		letter4.text = word[2]
		
	elif len(word) == 4:
		letter5.visible = false
		letter1.set_position(Vector2(-letter_width*1.5*spacing,0))
		letter2.set_position(Vector2(-letter_width*0.5*spacing,0))
		letter3.set_position(Vector2(letter_width*0.5*spacing,0))
		letter4.set_position(Vector2(letter_width*1.5*spacing,0))
		letter1.text = word[0]
		letter2.text = word[1]
		letter3.text = word[2]
		letter4.text = word[3]
		
	else: # len(word) == 5:
		letter1.set_position(Vector2(-letter_width*2*spacing,0))
		letter2.set_position(Vector2(-letter_width*1*spacing,0))
		letter3.set_position(Vector2(letter_width*0*spacing,0))
		letter4.set_position(Vector2(letter_width*1*spacing,0))
		letter5.set_position(Vector2(letter_width*2*spacing,0))
		letter1.text = word[0]
		letter2.text = word[1]
		letter3.text = word[2]
		letter4.text = word[3]
		letter5.text = word[4]
		
func getASCIIValue(word: String) -> Array:
	var word_sprite_list = []
	for i in word:
		word_sprite_list.append(i.to_ascii_buffer()[0])
	return word_sprite_list	

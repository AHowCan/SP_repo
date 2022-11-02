extends Node2D

var word_count = 25
var word = ""
var dead = false
var boost_word = false
var dir

const letter_width = 58
const letter_height = 92
const letter_scale = 0.60
const spacing = 1 * letter_scale

onready var letter1 = $LetterInstance/Letter_1
onready var letter2 = $LetterInstance/Letter_2
onready var letter3 = $LetterInstance/Letter_3
onready var letter4 = $LetterInstance/Letter_4
onready var letter5 = $LetterInstance/Letter_5
onready var cloud = $Cloud


onready var letter_list = {
	65 : preload("res://assets/letters/A.png"),
	97 : Rect2(letter_width - letter_width, 0, letter_width, letter_height),
	66 : preload("res://assets/letters/B.png"),
	98 : Rect2(letter_width,0, letter_width, letter_height),
	67 : preload("res://assets/letters/C.png"),
	99 : Rect2(letter_width * 2, 0, letter_width, letter_height),
	68 : preload("res://assets/letters/D.png"),
	100 : Rect2(letter_width * 3, 0, letter_width, letter_height),
	69 : preload("res://assets/letters/E.png"),
	101 : Rect2(letter_width * 4, 0, letter_width, letter_height),
	70 : preload("res://assets/letters/F.png"),
	102 : Rect2(letter_width * 5, 0, letter_width, letter_height),
	71 : preload("res://assets/letters/G.png"),
	103 : Rect2(letter_width * 6, 0, letter_width, letter_height),
	72 : preload("res://assets/letters/H.png"),
	104 : Rect2(letter_width * 7, 0, letter_width, letter_height),
	73 : preload("res://assets/letters/I.png"),
	105 : Rect2(letter_width * 8, 0, letter_width, letter_height),
	74 : preload("res://assets/letters/J.png"),
	106 : Rect2(letter_width * 9, 0, letter_width, letter_height),
	75 : preload("res://assets/letters/K.png"),
	107 : Rect2(letter_width * 10, 0, letter_width, letter_height),
	76 : preload("res://assets/letters/L.png"),
	108 : Rect2(letter_width * 11, 0, letter_width, letter_height),
	77 : preload("res://assets/letters/M.png"),
	109 : Rect2(letter_width * 12, 0, letter_width, letter_height),
	78 : preload("res://assets/letters/N.png"),
	110 : Rect2(letter_width * 13, 0, letter_width, letter_height),
	79 : preload("res://assets/letters/O.png"),
	111 : Rect2(letter_width * 14, 0, letter_width, letter_height),
	80 : preload("res://assets/letters/P.png"),
	112 : Rect2(letter_width * 15, 0, letter_width, letter_height),
	81 : preload("res://assets/letters/Q.png"),
	113 : Rect2(letter_width * 16, 0, letter_width, letter_height),
	82 : preload("res://assets/letters/R.png"),
	114 : Rect2(letter_width * 17, 0, letter_width, letter_height),
	83 : preload("res://assets/letters/S.png"),
	115 : Rect2(letter_width * 18, 0, letter_width, letter_height),
	84 : preload("res://assets/letters/T.png"),
	116 : Rect2(letter_width * 19, 0, letter_width, letter_height),
	85 : preload("res://assets/letters/U.png"),
	117 : Rect2(letter_width * 20, 0, letter_width, letter_height),
	86 : preload("res://assets/letters/V.png"),
	118 : Rect2(letter_width * 21, 0, letter_width, letter_height),
	87 : preload("res://assets/letters/W.png"),
	119 : Rect2(letter_width * 22, 0, letter_width, letter_height),
	88 : preload("res://assets/letters/X.png"),
	120 : Rect2(letter_width * 23, 0, letter_width, letter_height),
	89 : preload("res://assets/letters/Y.png"),
	121 : Rect2(letter_width * 24, 0, letter_width, letter_height),
	90 : preload("res://assets/letters/Z.png"),
	122 : Rect2(letter_width * 25, 0, letter_width, letter_height)
}

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

onready var oddletter1 = $OddLetterPos/Letter1
onready var oddletter2 = $OddLetterPos/Letter2
onready var oddletter3 = $OddLetterPos/Letter3
onready var oddletter4 = $OddLetterPos/Letter4
onready var oddletter5 = $OddLetterPos/Letter5

onready var evenletter1 = $EvenLetterPos/Letter1
onready var evenletter2 = $EvenLetterPos/Letter2
onready var evenletter3 = $EvenLetterPos/Letter3
onready var evenletter4 = $EvenLetterPos/Letter4

func gen_word() -> int:
	randomize()
	var index = randi() % word_count + 1
	while word_used[index] != 0:
		index +=1
		if index > word_count:
			index = 0
		
		#index = randi() % nnControll.word_count + 1
	word_used[index] = 1
	return words[index]

func generate_word() -> String:
	randomize()
	var index = randi()%20+1
	return words[index]
	
func _ready():
	oddletter1.set_position(Vector2(-letter_width*2*spacing,0))
	oddletter2.set_position(Vector2(-letter_width*1*spacing,0))
	oddletter3.set_position(Vector2(-letter_width*0*spacing,0))
	oddletter4.set_position(Vector2(letter_width*1*spacing,0))
	oddletter5.set_position(Vector2(letter_width*2*spacing,0))
	evenletter1.set_position(Vector2(-letter_width*2*spacing,0))
	evenletter2.set_position(Vector2(-letter_width*1*spacing,0))
	evenletter3.set_position(Vector2(letter_width*0*spacing,0))
	evenletter4.set_position(Vector2(letter_width*1*spacing,0))
	
	
func spawn(word: String):
	self.word = word
	var asciiword = getASCIIValue(word)
	var is_finished = getLetterPositions(asciiword)
	cloud.scale.x = len(asciiword) * letter_scale * 0.6
	if len(asciiword) == 4:
		cloud.global_position.x = cloud.global_position.x - letter_width * 0.4


func _process(delta: float) -> void:
	pass

func getASCIIValue(word: String) -> Array:
	var word_sprite_list = []
	for i in word:
		word_sprite_list.append(ord(i))
	return word_sprite_list
	
func getLetterPositions(word_sprite_list: Array) -> bool:
	var word_length = len(word_sprite_list)
	if word_length == 2:
		letter1.position = evenletter2.position
		letter2.position = evenletter3.position
		letter1.set_region_rect(letter_list[word_sprite_list[0]])
		letter2.set_region_rect(letter_list[word_sprite_list[1]])
		letter1.visible = true
		letter2.visible = true
		letter1.set_scale(Vector2(letter_scale, letter_scale))
		letter2.set_scale(Vector2(letter_scale, letter_scale))
	elif word_length == 3:
		letter1.position = oddletter2.position
		letter2.position = oddletter3.position
		letter3.position = oddletter4.position
		letter1.set_region_rect(letter_list[word_sprite_list[0]])
		letter2.set_region_rect(letter_list[word_sprite_list[1]])
		letter3.set_region_rect(letter_list[word_sprite_list[2]])
		letter1.visible = true
		letter2.visible = true
		letter3.visible = true
		letter1.set_scale(Vector2(letter_scale, letter_scale))
		letter2.set_scale(Vector2(letter_scale, letter_scale))
		letter3.set_scale(Vector2(letter_scale, letter_scale))
	elif word_length == 4:
		letter1.position = evenletter1.position
		letter2.position = evenletter2.position
		letter3.position = evenletter3.position
		letter4.position = evenletter4.position
		letter1.set_region_rect(letter_list[word_sprite_list[0]])
		letter2.set_region_rect(letter_list[word_sprite_list[1]])
		letter3.set_region_rect(letter_list[word_sprite_list[2]])
		letter4.set_region_rect(letter_list[word_sprite_list[3]])
		letter1.visible = true
		letter2.visible = true
		letter3.visible = true
		letter4.visible = true
		letter1.set_scale(Vector2(letter_scale, letter_scale))
		letter2.set_scale(Vector2(letter_scale, letter_scale))
		letter3.set_scale(Vector2(letter_scale, letter_scale))
		letter4.set_scale(Vector2(letter_scale, letter_scale))
	elif word_length == 5:
		letter1.position = oddletter1.position
		letter2.position = oddletter2.position
		letter3.position = oddletter3.position
		letter4.position = oddletter4.position
		letter5.position = oddletter5.position
		letter1.set_region_rect(letter_list[word_sprite_list[0]])
		letter2.set_region_rect(letter_list[word_sprite_list[1]])
		letter3.set_region_rect(letter_list[word_sprite_list[2]])
		letter4.set_region_rect(letter_list[word_sprite_list[3]])
		letter5.set_region_rect(letter_list[word_sprite_list[4]])
		letter1.visible = true
		letter2.visible = true
		letter3.visible = true
		letter4.visible = true
		letter5.visible = true
		letter1.set_scale(Vector2(letter_scale, letter_scale))
		letter2.set_scale(Vector2(letter_scale, letter_scale))
		letter3.set_scale(Vector2(letter_scale, letter_scale))
		letter4.set_scale(Vector2(letter_scale, letter_scale))
		letter5.set_scale(Vector2(letter_scale, letter_scale))
	return true
	
func boost_movement() -> void:
	pass
	
func _on_Area2D_body_entered(body: Node) -> void:
	pass
	#dead = true
	



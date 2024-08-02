extends Node2D

var word = ""
var dead = false
@onready var label = get_node("Label")
@onready var nnControll = get_parent()
var player = null

var words = {
	1 : "rocket",
	2 : "boost",
	3 : "laser",
	4 : "bomb",
	5 : "star",
	6 : "word",
	7 : "spike",
	8 : "space",
	9 : "planet",
	10: "blob",
	11: "locate",
	12: "stress",
	13: "destroy",
	14: "fin",
	15: "begin",
	16: "meteor",
	17: "kick",
	18: "twamp",
	19: "air",
	20: "empty",
	21: "orbit",
	22: "waxing",
	23: "waning",
	24: "nebula",
	25: "ring"
}

func _ready() -> void:
	#word = generate_word()
	word = gen_word()

func gen_word() -> int:
	randomize()
	var index = randi() % nnControll.word_count + 1
	while nnControll.word_used[index] != 0:
		index +=1
		if index > nnControll.word_count:
			index = 1
		#index = randi() % nnControll.word_count + 1
	nnControll.word_used[index] = 1
	label.name = nnControll.words[index]
	label.text = nnControll.words[index]
	return nnControll.words[index]

func generate_word() -> String:
	randomize()
	var index = randi()%20+1
	label.name = words[index]
	label.text = words[index]
	return words[index]

func _on_Area_1_body_entered(body: Node) -> void:
	print("Player entered area")
	dead = true
	
func _on_Area2D_body_entered(body: Node) -> void:
	print("Player entered area")
	dead = true

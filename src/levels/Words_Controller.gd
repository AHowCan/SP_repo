extends Node2D

var word_count = 25

onready var level = get_parent()
onready var player = level.get_node("Player")

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

func _ready():
	yield(get_tree().root, "ready")
	for child in self.get_children():
		var word = gen_word()
		child.spawn(word)
		level.enemyList.append(child)
		level.wordList.append(child)
		player.wordList.append(child)
		player.killed.append(0)

func gen_word() -> int:
	randomize()
	var index = randi() % word_count + 1
	while word_used[index] != 0:
		index +=1
		if index > word_count:
			index = 1
		
		#index = randi() % nnControll.word_count + 1
	word_used[index] = 1
	return words[index]

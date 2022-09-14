extends Node2D

var navi_node_list = []
var word_count = 25
var words = {
	1 : "rocket",
	2 : "light",
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

onready var level = get_parent()
onready var player = level.get_node("Player")

func _ready():
	for i in self.get_children():
		level.wordList.append(i.word)
		level.enemyList.append(i)
		player.wordList.append(i)
		player.killed.append(0)
		

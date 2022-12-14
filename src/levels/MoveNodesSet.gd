extends TileMap

onready var mnode_1 = $MNode_1

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
	20: "empty"
}

func generate_word() -> String:
	randomize()
	var index = randi()%20+1
	return words[index]


extends Area2D

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
onready var player = get_parent()

func generate_word() -> String:
	randomize()
	var index = randi()%20+1
	return words[index]

#func _on_NodeDetectArea_area_entered(area: Area2D) -> void:
#	print(area.get_parent().name)
#	var mnode = area.get_parent()
#	mnode.visible = true
#	var mnode_label = mnode.get_child(2)
#	var word = generate_word()
#	mnode_label.text = word


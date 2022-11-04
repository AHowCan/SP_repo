extends Node

var text_to_update = ""
onready var label = $Label
onready var cur_word = label.get_text()

#func _process(delta: float) -> void:
#	if cur_word != text_to_update:
#		label.text = text_to_update

func update_word(word: String) -> void:
	label.text = word


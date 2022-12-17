extends Node

var text_to_update = ""
onready var label = $Label
onready var border = $border
onready var lockborder = $lockborder
onready var cur_word = label.get_text()

func update_word(word: String) -> void:
	label.text = word

func lock_unlock_border(lock: bool) -> void:
	if lock:
		lockborder.visible = true
		border.visible = false
	else:
		border.visible = true
		lockborder.visible = false

extends Node

onready var border = $Border
onready var panel = $Panel

func remove_title_screen() -> void:
	border.visible = false
	panel.visible = false

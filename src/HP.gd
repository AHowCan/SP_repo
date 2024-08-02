extends Node

var hp_tracker = 100

@onready var hp = $hp

func _ready():
	pass # Replace with function body.

func take_damage() -> void:
	hp_tracker = hp_tracker - 50
	var value = "HP: %s" % hp_tracker
	hp.text = value
	
	


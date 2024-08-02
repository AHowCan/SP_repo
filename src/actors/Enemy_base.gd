###
# Base class for enemy types
###

extends CharacterBody2D

@onready var behavior = $Behavior

var fsm = 1
var word_pool = {
	1: "enemy",
	2: "rival",
	3: "rebel"
}

func _ready():
	var word = (randi() % len(word_pool)) + 1
	behavior.display_word(word_pool[word])
	idle_state() 

func idle_state():
	pass
	
func attack_state():
	pass
	





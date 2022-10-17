extends Node2D

var wordList = []
var enemyList = []
var level_boostWordList = []
var boostList = []
var index = 0
onready var player = get_node("Player")
onready var entry = get_node("TitleBox")

func _ready():
#	wordList.append(enemy_1.word)
#	wordList.append(enemy_2.word)
#	wordList.append(enemy_3.word)
#	player.wordList.append(wordList[0])
#	player.killed.append(0)
#	player.wordList.append(wordList[1])
#	player.killed.append(0)
#	player.wordList.append(wordList[2])
#	player.killed.append(0)
#	enemyList.append(enemy_1)
#	enemyList.append(enemy_2)
#	enemyList.append(enemy_3)
	
#	### Need to implement random boost words --- Temporarily manuall set
#	level_boostWordList.append("goo")
	
	### Need re-word
#	player.boostList.append(level_boostWordList[0])
#	player.boostKill.append(0)
	###boostWord_1.word = level_boostWordList[0]
	#boostList.append(boostWord_1)
	pass

func _process(delta: float) -> void:
	for enemy in enemyList:
		if enemy.dead == true:
			print("time to disappear")
			enemyList.erase(enemy)

			enemy.visible = false
			wordKilled(enemy)
			break
			
func wordKilled(enemy):
	player.wordList.remove(index)
	enemy.queue_free()

func _on_Area2D_body_entered(body: Node) -> void:
	print("Player detected")
	player.velocity = -((player.velocity) / 2)
	player.speed = int(player.speed / 2)
	if player.booster != 0:
		player.booster = 0
	player.direction = -(player.direction)

func _on_Button_button_up() -> void:
	entry.remove_title_screen()

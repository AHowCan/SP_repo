extends Node

var start_boost_sequence = false
var duration = 4
var start_boost_words = 2
var missed_boost_word = 5
var boost_interval = 2
var boost_id = 0
var max_boost_id = 3

@onready var boost_word1 = $BoostWord1
@onready var boost_word2 = $BoostWord2
@onready var boost_word3 = $BoostWord3
@onready var boost_words_list = []

@onready var player = get_parent()
@onready var player_dir = player.direction
@onready var player_vel = player.velocity

@onready var player_move_timer = $PlayerMoveTimer
@onready var boost_word_interval = $BoostIntervalTimer

func _ready():
	boost_words_list.append(boost_word1)
	boost_words_list.append(boost_word2)
	boost_words_list.append(boost_word3)
	player.boostNodes.append(boost_word1)
	player.boostNodes.append(boost_word2)
	player.boostNodes.append(boost_word3)
	
func _process(delta: float) -> void:
	player_dir = player.get_flight_direction()
	
	if start_boost_sequence:
		start_boost_sequence = false
		#print("startin boost sequence")
		#player_move_timer.start(start_boost_words)
		boost_word_interval.start(boost_interval)
		
func _on_PlayerMoveTimer_timeout() -> void:
	print("Timeout hit")
	player_move_timer.stop()
	boost_word1.dead = false
	boost_word1.boostMiss_timer.start(missed_boost_word)
	
func _on_BoostIntervalTimer_timeout() -> void:
	start_boost_sequence = true
	boost_words_list[boost_id].dead = false
	boost_words_list[boost_id].boostMiss_timer.start(missed_boost_word)
	boost_id += 1 # Increase to the next boost word
	boost_id %= max_boost_id # Start over if used last boost word

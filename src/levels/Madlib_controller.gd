extends Node2D

var story = ""
var words = {} # Keeps track of the chosen words for each word type 
var word_index = [] # Keeps track if the same word is used more then once
var madlib_zone_counter = 1
var madlib_zone_tracker = [] # 
const madlib_zone_scene_path = "res://src/Madlib/madlib_zone.tscn"

@onready var ml_pos = get_children()

signal clear_type_box()

func _ready():
	randomize()
	var madlib_zone = preload(madlib_zone_scene_path)
	
	story = MadlibStories.story_selection[randi() % 
				MadlibStories.story_selection.size()]
	
	# Set words{} and word_index[]
	set_needed_word_dict(story) 
	
	for i in range(len(word_index)):
		var ml_zone_child = madlib_zone.instantiate()
		add_child(ml_zone_child)
		ml_zone_child.set_position(Vector2(ml_pos[i].position.x, ml_pos[i].position.y))
		
		if i == 0:
			print(ml_pos[i].position.x)
			print(ml_pos[i].position.y)
		

		var random_word1 = MadlibWords.get_word(words[int(word_index[i])])
		var random_word2 = MadlibWords.get_word(words[int(word_index[i])])
		while random_word2 == random_word1:
			random_word2 = MadlibWords.get_word(words[int(word_index[i])])
		var random_word3 = MadlibWords.get_word(words[int(word_index[i])])
		while random_word3 == random_word1 or random_word3 == random_word2:
			random_word3 = MadlibWords.get_word(words[int(word_index[i])])

		ml_zone_child.zone_index = i
		ml_zone_child.set_words([random_word1, random_word2, random_word3])
		madlib_zone_tracker.append(ml_zone_child)
		ml_zone_child.connect('random_word_Seppuku', player_left_madlib)
	
func _process(delta):
	pass
	
func check_type_matches_ml_word(word):
	for madlib_zone in madlib_zone_tracker:
		if madlib_zone.ship_in_area:
			if word in madlib_zone.word_list:
				words[madlib_zone.zone_index] = word
				remove_and_delete_child(madlib_zone)
				emit_signal("clear_type_box")
				
		
func set_needed_word_dict(text):
	var regex = RegEx.new()
	regex.compile("\\[([0-9]+) ([a-zA-Z_]+)\\]")
	var counter = 1
	var matches = regex.search_all(text)
	
	for match in matches:
		words[counter] = match.get_string(2)
		counter += 1
		word_index.append(match.get_string(1))

func player_left_madlib(madlib_zone, choice):
	words[madlib_zone] = choice
	remove_and_delete_child(madlib_zone_tracker[madlib_zone])

func remove_and_delete_child(instantiated_node):
	if instantiated_node and instantiated_node.get_parent() == self:
		madlib_zone_tracker.erase(instantiated_node)
		remove_child(instantiated_node)
		instantiated_node.queue_free()
		instantiated_node = null

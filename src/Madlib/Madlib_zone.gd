extends Node2D

var ship_in_area = false

var zone_index: int
var word1 = ""
var word2 = ""
var word3 = ""
var word_list = []
var spawn = false

@onready var tunnel_shader = $tunnel_shader
const word_controller_path = "res://src/Madlib/ML_Word_Coordinate.tscn"

var word_controller
var word1_marker
var word2_marker
var word3_marker

signal random_word_Seppuku(zone_index, word)

# Called when the node enters the scene tree for the first time.
func _ready():
	word_controller = preload(word_controller_path)
	word1_marker = $word1_marker
	word2_marker = $word2_marker
	word3_marker = $word3_marker


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
		
func _on_body_entered(body):
	if body.name == "Player" and not ship_in_area: 
		ship_in_area = true
		tunnel_shader.visible = true
		var instance1 = word_controller.instantiate()
		word1_marker.add_child(instance1)
		instance1.create_word_coordinate(word1)
		
		var instance2 = word_controller.instantiate()
		word2_marker.add_child(instance2)
		instance2.create_word_coordinate(word2)
		
		var instance3 = word_controller.instantiate()
		word3_marker.add_child(instance3)
		instance3.create_word_coordinate(word3)
		
		word_list.append(word1)
		word_list.append(word2)
		word_list.append(word3)
	

func _on_body_exited(body):
	if body.name == "Player": 
		ship_in_area = false
		tunnel_shader.visible = false
		var rand_choice = randi_range(1,3)
		if rand_choice == 1:
			emit_signal("random_word_Seppuku", zone_index, word1)
		elif rand_choice == 2:
			emit_signal("random_word_Seppuku", zone_index, word2)
		else:
			emit_signal("random_word_Seppuku", zone_index, word3)
		
func set_words(word_list):
	word1 = word_list[0]
	word2 = word_list[1]
	word3 = word_list[2]
	
		

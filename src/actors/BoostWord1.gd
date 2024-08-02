extends CharacterBody2D

var word_velocity = Vector2.ZERO
var word_direction = Vector2.ZERO
var get_boost = false
var dead = true
var duration = 4
var count = 0
var word : String
var word_list = {
	1 : "fuel",
	2 : "speed",
	3 : "fast",
	4 : "vroom",
	5 : "faster",
	6 : "swoosh",
	7 : "swish",
	8 : "boost",
	9 : "dash",
	10 : "dart"
}
@export var MAX_SPEED = 15
@export var ACCELERATION = 15

@onready var player = get_parent().get_parent()
@onready var boost_controller = get_parent()
@onready var boostMiss_timer = $BoostMissTimer
@onready var boost_duration_timer = $BoostDurationTimer
@onready var word_label = $Label
	
func generate_word() -> String:
	randomize()
	var index = randi() % 10 + 1
	return word_list[index]
	
func _ready():
	self.visible = false
	word = generate_word()
	word_label.text = word	
	
func _physics_process(delta: float) -> void:
	if dead == false:
		self.visible = true
		word_velocity = word_velocity.move_toward(-boost_controller.player_dir * MAX_SPEED, ACCELERATION * delta)
		set_velocity(word_velocity)
		move_and_slide()
		word_velocity = velocity
	else:
		self.visible = false
		self.position = player.position # Need to offset here
		self.position += -boost_controller.player_dir * 70
			

func _on_BoostMissTimer_timeout() -> void:
	dead = true
	word = generate_word()
	word_label.text = word	

func _on_BoostDurationTimer_timeout() -> void:
	#player.MAX_SPEED -= player.booster
	player.booster = 0
	boost_duration_timer.stop()
	

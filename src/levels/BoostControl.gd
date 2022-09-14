extends Actor

var word_velocity = Vector2.ZERO
var word_direction = Vector2.ZERO
var get_boost = false
var dead = true
var word : String
var boostDead = []
var total_boost

#export var FRICTION = 500
export var MAX_SPEED = 15
export var ACCELERATION = 15
var increase_speed = 1

onready var player = get_parent().get_parent()
onready var dir = player.direction
onready var vel = player.velocity

onready var bword = get_node("BoostWord")
onready var timer = $Timer
var duration = 3
var count = 0

var word_list = {
	1 : "fuel",
	2 : "speed",
	3 : "fast",
	4 : "vroom"
}

func _init() -> void:
	word = generate_word()

func generate_word() -> String:
	randomize()
	var index = randi()%4+1
	return word_list[index]

func _ready():
	self.visible = false
	bword.text = word

func _physics_process(delta: float) -> void:

	if dir != player.direction:
		dir = player.direction

	#create_word_boost()
	if dead == false:
		print("Boost Word send")
		if get_boost:
			self.visible = true
			word_velocity = word_velocity.move_toward(-dir * MAX_SPEED, ACCELERATION * delta)
			word_velocity = move_and_slide(word_velocity)
		else:
			self.visible = false
			self.position = player.position
	else:
		self.visible = false
		self.position = player.position

func initiate_boost_word() -> void:
	pass

func disable_word() -> void:
	pass

func _on_Timer_timeout() -> void:
	get_boost = false
	dead = true
	self.position = player.position
	self.dir = Vector2.ZERO


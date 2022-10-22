extends Actor

onready var point = Vector2(600,400)
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var null_vector = Vector2.ZERO
var enemy_loc = Vector2.ZERO
var enemy_target = Vector2.ZERO
var FRICTION = 500
var player_is_moving = false
var speed = 0
var booster = 0
var cur_position
var target_coord
var target_node
export var MAX_SPEED = 140	
export var ACCELERATION = 200
export var boost_amount = 160
export var TURNSPEED = 30
var decelaration = 0 # originally 150

onready var level = get_tree().get_root().get_node("LevelTemplate")
onready var textB = get_tree().get_root().get_node("LevelTemplate/UI/TypeBox")
onready var speed_meter = get_tree().get_root().get_node("LevelTemplate/UI/SpeedMeter")
#onready var enemy = get_node("../Area_1")
onready var timer = get_node("Timer")
#onready var boost_respawn_timer = $Boost_Respawn
onready var boost_duration_timer = $BoostController/BoostWord1/BoostDurationTimer
onready var boost_controller = $BoostController
onready var boost_word1 = get_node("BoostController/BoostWord1")
#onready var word_boost2 = get_node("BoostController/BoostControl2")
onready var direction_dot = $DirectionDot

var typed = false
var lock_direction = true
var death_direction = Vector2.ZERO
var unlock_direction = Vector2.ZERO
var typist = [] 
var typing = ""
var wordList = []
var killed = []
var enemy_list = []
var boostNodes = []
var min_word_length = 3
var num_of_boosts = 3
var output_boost_word = false

var test_var = Vector2.ZERO

onready var area_1

func _ready():
	set_process_input(true) 
	enemy_list = level.enemyList
	cur_position = Vector2(self.position.x, self.position.y)
	target_coord = cur_position
	$AnimatedSprite.play("idle")

func _physics_process(delta: float) -> void:
	### Check various typing matches
	if typed:
		if not wordList.empty():
			var temp_enem_loc = point_word_typed(delta, velocity)
			if Vector2.ONE != temp_enem_loc and enemy_loc != temp_enem_loc:
				lock_direction = true
				enemy_loc = temp_enem_loc
			velocity = boost_word_typed(delta, velocity)
		typed = false
	
	### Check if player is moving
	if is_player_moving() and !player_is_moving:
		player_is_moving = true
		boost_controller.start_boost_sequence = true

	velocity = move_player(delta) # Move the player
	if !speed_meter.zeroToMax:
		speed_meter() # Calculate and update speed meter


func move_player(delta: float) -> Vector2:
	direction = (enemy_loc - global_position).normalized()
	if not lock_direction:
		direction = unlock_direction
	else:
		direction = (enemy_loc - global_position).normalized()
	
	velocity = velocity.move_toward(direction * (speed + booster), ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	return velocity
	
func speed_meter() -> void:
	var speed_divison = int(floor(MAX_SPEED / 8	)) # There's eight divisions, each worth this var
	var count = speed / speed_divison
	speed_meter.frame = count
	
func is_player_moving() -> bool:
	var position = Vector2(self.position.x, self.position.y)
	if position != cur_position:
		#print(position)
		cur_position = position
		return true
	else:
		return false

# Interrupt handler by godot calls when an 'event' happens (key pressed)
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() == true and event.scancode == KEY_BACKSPACE  and not event.echo:
		typist.pop_back()
		typing.erase(-1,  1)
		typed = true
	elif event is InputEventKey and event.is_pressed() == true and event.scancode == KEY_SHIFT and not event.echo:
		pass
		#increase_speed()
	elif event is InputEventKey and event.is_pressed() == true and event.scancode == KEY_SPACE and not event.echo:
		if lock_direction:
			lock_direction = false
		else:
			lock_direction = true
		unlock_direction = direction
		#decrease_speed()
	elif event is InputEventKey and event.is_pressed() == true and event.scancode == KEY_ENTER  and not event.echo:
		typist = []
		typing = ""
		typed = false
	elif event is InputEventKey and event.is_pressed() == true and not event.echo:
		typist.append(OS.get_scancode_string(event.scancode).to_lower())
		if typist.size() > 7:
			typist.pop_front()
		typed = true
	
	# Updates the text box with what the player is typing
	update_player_text_box()

func get_flight_direction() -> Vector2:
	return direction
	
func get_flight_velocity() -> Vector2:
	return velocity
	
func update_player_text_box() -> void:
	if !typist.empty():
		# Combine array into single string for display
		for i in range(0, typist.size()):
			typing += typist[i]
		
		textB.update_word(typing)
		typing = ""
	else:
		textB.update_word(" ")

func increase_speed(amount: int = 20) -> void:
	if speed + amount <= MAX_SPEED:
		speed += amount

func decrease_speed(amount : int = 20) -> void:
	if speed - amount >= 0:
		speed -= amount
	if booster > 0:
		booster -= amount
		
func boost_word_typed(delta: float, velocity: Vector2) -> Vector2:
	var index = 0
	for wordNode in boostNodes:
		if !wordNode.dead:
			var min_length = min(typist.size(), wordNode.word.length())
			for i in min_length:
				if wordNode.word[i] != typist[i]:
					break
				else:
					if wordNode.word.length() - 1 == i:
						#print("Found a boost word")
						typist = []
						#boost_respawn_timer.start(5)
						remove_word(index, boostNodes)
						#MAX_SPEED += booster
						booster = boost_amount
						#velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
						boost_duration_timer.start(4)
		index += 1
	return velocity

func point_word_typed(delta: float, velocity: Vector2) -> Vector2:
	var index = 0
	for enemy in enemy_list:
		if typist.size() == enemy.word.length():
			for i in typist.size():
				if typist[i] != enemy.word[i]:
					break
				else:
					if enemy.word.length() - 1 == i:
						typist = []
						#decelaration = 0
						#booster = 0
						level.index = index
						#direction = (enemy.position - global_position).normalized()
						speed = MAX_SPEED
						speed_meter.zero_to_max()
						#direction = (level.enemyList[index].global_position - global_position).normalized()
						#return (enemy.position - global_position).normalized()
						return enemy.position
						#return velocity
			index += 1
	#return velocity
	return Vector2.ONE
	
func remove_word(index: int, word_list: Array) -> void:
	if word_list == boostNodes:
		boostNodes[index].dead = true
		boostNodes[index].visible = false

#func death_direction() -> void:
#	print('set death_dir')
#	death_direction = direction

func timer_for_word_boosts(start: bool) -> void:
	if start:
		timer.start(1)

func begin_boost_sequence() -> void:
	pass

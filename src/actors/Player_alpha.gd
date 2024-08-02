extends Actor

@onready var point = Vector2(600,400)
var veloc = Vector2.ZERO
var dir = Vector2.ZERO
var prev_dir = Vector2.ZERO
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
@export var MAX_SPEED = 180	
@export var ACCELERATION = 200
@export var boost_amount = 160
@export var TURNSPEED = 30
var decelaration = 0 # originally 150

@onready var textB = get_parent().get_child(1).get_child(1)
@onready var texttarget = get_parent().get_child(1).get_child(2)
@onready var hp = get_parent().get_child(1).get_child(3)
var word_location = {}

@onready var timer = get_node("Timer")
@onready var recover_timer = get_node("Timers/recover_timer")
@onready var boost_duration_timer = $BoostController/BoostWord1/BoostDurationTimer
@onready var boost_controller = $BoostController
@onready var boost_word1 = get_node("BoostController/BoostWord1")
@onready var dir_dot = $dirdot
@onready var movement_trail = $TailParticles


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
var body_HP = 100
var output_boost_word = false
var collision_pos = Vector2.ZERO
var pre_vel = Vector2.ZERO

var test_var = Vector2.ZERO

@onready var area_1

var fsm = 0 
# State Machine
   # 0: Idle
   # 1: Move
   # 2: Hit
   # 3: 


func _ready():
	set_process_input(true) 
	cur_position = Vector2(self.position.x, self.position.y)
	target_coord = cur_position
	$AnimatedSprite2D.play("idle")
	fsm = 1
	

func _physics_process(delta: float) -> void:
	### Check various typing matches
	if typed:
		if not wordList.is_empty():
			var temp_enem_loc = point_word_typed(delta, veloc)
			if Vector2.ONE != temp_enem_loc and enemy_loc != temp_enem_loc:
				lock_direction = true
				enemy_loc = temp_enem_loc
			veloc = boost_word_typed(delta, veloc)
		typed = false
	
	### Check if player is moving
	if is_player_moving() and !player_is_moving:
		movement_trail.emitting= true
		player_is_moving = true
		boost_controller.start_boost_sequence = true

	if fsm == 0:
		idle_movement()
	if fsm == 1:
		veloc = move_player(delta) # Move the player
	if fsm == 2: 
		veloc = hit_movement(delta)
	
	#if !speed_meter.zeroToMax:
		#speed_meter() # Calculate and update speed meter
	
	dir = self.global_position
	movement_trail.direction = -(dir - prev_dir)
	prev_dir = dir

func idle_movement() -> void:
	print("Idle")
	movement_trail.emitting= false
	dir = cur_position
	direction = cur_position
	unlock_direction = cur_position
	veloc = cur_position
	enemy_loc = cur_position
	enemy_target = cur_position
	dir_dot.position = cur_position
	

func move_player(delta: float) -> Vector2:
	direction = (enemy_loc - global_position).normalized()
	if not lock_direction:
		
		direction = unlock_direction
	else:
		direction = (enemy_loc - global_position).normalized()
	
	#veloc = veloc.move_toward(direction * (speed + booster), ACCELERATION * delta)
	#veloc = move_and_slide(veloc)
		
	for i in get_slide_collision_count():
		if recover_timer.is_stopped():
			recover_timer.start(4)
			print("Collided " + str(unlock_direction) + " - " + str(self.position))
			unlock_direction = -unlock_direction

				
	#print("Before " + str(pre_vel))
	veloc = veloc.move_toward(direction * (speed + booster), ACCELERATION * delta)
	dir_dot.position = veloc
	set_velocity(veloc)
	move_and_slide()
	veloc = veloc			
	
	return veloc

func hit_movement(delta: float) -> Vector2:
	movement_trail.emitting= false
	veloc = veloc.move_toward(-direction * (-speed), ACCELERATION * delta)
	set_velocity(veloc)
	move_and_slide()
	veloc = veloc	
	dir_dot.position = veloc
	direction = direction * (0.05 * delta)
	print("hit_movement")
	if recover_timer.is_stopped():
		fsm = 0
		veloc = Vector2.ZERO
	return veloc

	
func speed_meter() -> void:
	var speed_divison = int(floor(MAX_SPEED / 8	)) # There's eight divisions, each worth this var
	var count = speed / speed_divison
	#speed_meter.frame = count
	
func is_player_moving() -> bool:
	var position = Vector2(self.position.x, self.position.y)
	if position != cur_position:
		cur_position = position
		return true
	else:
		return false

# Interrupt handler by godot calls when an 'event' happens (key pressed)
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() == true and event.keycode == KEY_BACKSPACE  and not event.echo:
		typist.pop_back()
		typing.erase(-1,  1)
		typed = true
	elif event is InputEventKey and event.is_pressed() == true and event.keycode == KEY_SHIFT and not event.echo:
		pass
		#increase_speed()
	elif event is InputEventKey and event.is_pressed() == true and event.keycode == KEY_SPACE and not event.echo:
		if lock_direction:
			texttarget.lock_unlock_border(not lock_direction)
			lock_direction = false
		else:
			texttarget.lock_unlock_border(not lock_direction)
			lock_direction = true
		unlock_direction = direction
		#decrease_speed()
	elif event is InputEventKey and event.is_pressed() == true and event.keycode == KEY_ENTER  and not event.echo:
		typist = []
		typing = ""
		typed = false
	elif event is InputEventKey and event.is_pressed() == true and not event.echo:
		typist.append(OS.get_keycode_string(event.keycode).to_lower())
		if typist.size() > 7:
			typist.pop_front()
		typed = true
	
	# Updates the text box with what the player is typing
	update_player_text_box()

func get_flight_direction() -> Vector2:
	return direction
	
func get_flight_velocity() -> Vector2:
	return veloc
	
func update_player_text_box() -> void:
	if !typist.is_empty():
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
		
func boost_word_typed(delta: float, veloc: Vector2) -> Vector2:
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
						#veloc = veloc.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
						boost_duration_timer.start(4)
		index += 1
	return veloc

func point_word_typed(delta: float, veloc: Vector2) -> Vector2:
	var index = 0
	for enemy in wordList:
		if typist.size() == len(enemy):
			for i in typist.size():
				if typist[i] != enemy[i]:
					break
				else:
					if len(enemy) - 1 == i:
						movement_trail.emitting= true
						fsm = 1
						typist = []
						texttarget.lock_unlock_border(true)
						texttarget.update_word(enemy)
						#level.index = index
						#direction = (enemy.position - global_position).normalized()
						speed = MAX_SPEED
						#speed_meter.zero_to_max()
						#direction = (level.enemyList[index].global_position - global_position).normalized()
						#return (enemy.position - global_position).normalized()
						#return enemy.position
						return word_location[enemy]
						#return veloc
			index += 1
	#return veloc
	return Vector2.ONE
	
func remove_word(index: int, word_list: Array) -> void:
	if word_list == boostNodes:
		boostNodes[index].dead = true
		boostNodes[index].visible = false

func timer_for_word_boosts(start: bool) -> void:
	if start:
		timer.start(1)

func begin_boost_sequence() -> void:
	pass

func hit_wall(body):
	if recover_timer.is_stopped():
		recover_timer.start(3)
		unlock_direction = -unlock_direction
		direction = -direction
		veloc = -veloc
		dir = -dir
		fsm = 2
		print("hit wall, HP = %s" % body_HP)
		hp.take_damage()
		if hp.hp_tracker < 1:
			game_over()
		#print(str(collision_pos) + " " + str(self.position))
		clear_text_target()
		if body_HP > 1:
			body_HP = body_HP - 10
			body_damage_anim()
		else:
			game_over()	
	
func game_over():
	pass
	get_tree().quit()

func body_damage_anim():
	pass
	
func clear_text_target():
	typist = []
	typing = ""
	typed = false
	texttarget.update_word("")
	
func _on_NodeDetectArea_body_entered(body):
	if body.name != "Player":
		hit_wall(body)

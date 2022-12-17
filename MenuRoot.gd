extends Control

var menu_origin_pos := Vector2.ZERO
var menu_origin_size := Vector2.ZERO

var current_menu
var menu_stack := []
var menu_transition_time := 0.5

onready var menu_1 = $MainMenu
onready var menu_2 = $SideMenu
onready var tween = $Tween
onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	menu_origin_pos = Vector2(0,0)
	menu_origin_size = get_viewport_rect().size
	current_menu = menu_1
	anim.play("fade_in")
	
func move_to_next_menu(next_menu_id: String):
	var next_menu = get_menu_from_menu_id((next_menu_id))
	#current_menu.rect_global_position = Vector2(-menu_origin_size.x, 0)
	#next_menu.rect_global_position = menu_origin_pos
	tween.interpolate_property(
		current_menu, 
		"rect_global_position", 
		current_menu.rect_global_position, 
		Vector2(-menu_origin_size.x, 0),
		menu_transition_time,Tween.TRANS_SINE)
	tween.interpolate_property(
		next_menu, 
		"rect_global_position", 
		next_menu.rect_global_position, 
		menu_origin_pos,
		menu_transition_time,Tween.TRANS_SINE)
	tween.start()
	menu_stack.append(current_menu)
	current_menu = next_menu
	
func move_to_prev_menu():
	var prev_menu = menu_stack.pop_back()
	if prev_menu != null:
		#prev_menu.rect_global_position = menu_origin_pos
		#current_menu.rect_global_position = Vector2(menu_origin_size.x, 0)
		tween.interpolate_property(
			prev_menu, 
			"rect_global_position", 
			prev_menu.rect_global_position, 
			menu_origin_pos,
			menu_transition_time)
		tween.interpolate_property(
			current_menu, 
			"rect_global_position", 
			current_menu.rect_global_position, 
			Vector2(menu_origin_size.x, 0),
			menu_transition_time)
		tween.start()
		current_menu = prev_menu
	
func get_menu_from_menu_id(menu_id: String) -> Control:
	match menu_id:
		"menu_1":
			return menu_1
		"menu_2":
			return menu_2
		_:
			return menu_1
	

func _on_ToolButton2_pressed():
	move_to_next_menu("menu_2")


func _on_ToolButton_pressed():
	move_to_prev_menu()

extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_index = -1
var dialogue = 0
var is_active = false
var initial_dialogue = true
var finished = false

func _ready():
	$NinePatchRect.visible = false

func play():
	if is_active:
		return
	dialogues = load_dialogue()
	
	is_active = true
	desactivate_movement()
	$NinePatchRect.visible = true
	next_line()
	
# Detect when the user press the button for next dialogue line
func _input(event):
	if not is_active:
		return
	# Go to the next line only if the current text has finished its animation
	if(finished):
		if Input.is_action_just_pressed("game_action"):
			next_line()

func next_line():
	current_dialogue_index += 1
	finished = false
	#Only if we are in the initial dialogue we check if the lenght of it is higher than the current index
	if current_dialogue_index >= len(dialogues):
		var npc = get_parent()
		$Timer.start()
		$NinePatchRect.visible = false
		activate_movement()
		initial_dialogue = false
		npc.move()
		return
		
	$NinePatchRect/name.text = dialogues[current_dialogue_index]["name"]
	$NinePatchRect/message.text = dialogues[current_dialogue_index]["message"]
	$NinePatchRect/message.percent_visible = 0
	$NinePatchRect/Tween.interpolate_property(
		$NinePatchRect/message, "percent_visible", 0, 1, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$NinePatchRect/Tween.start()

# Load file that contains the dialogues
func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func desactivate_movement():
	var player = get_tree().get_root().find_node("player",true,false)
	if player:
		player.set_active(false)
		
func activate_movement():
	var player = get_tree().get_root().find_node("player",true,false)
	if player:
		player.set_active(true)

func _on_Timer_timeout():
	is_active = false


func _on_Tween_tween_completed(object, key):
	finished = true

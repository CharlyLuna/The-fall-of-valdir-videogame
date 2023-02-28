extends Control

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_index = 0
var dialogue = 0
var is_active = false
var initial_dialogue = true
var finished = false
signal finished_dialogue()
var character = Global.character
# Call the desicion box
signal show_desicion(message, options)

func _ready():
	$NinePatchRect.visible = false

func play():
	if is_active:
		return
	dialogues = load_dialogue()
	
	is_active = true
	desactivate_movement()
	$NinePatchRect.visible = true
	
	# Reset the current index
	current_dialogue_index = -1
	# Check if the normal dialogue has finished and set the dialogue to the default line: 1
	if not initial_dialogue:
		dialogue = 1
	next_line()
	
# Detect when the user press the button for next dialogue line
func _input(event):
	if not is_active:
		return
	# Go to the next line only if the current text has finished its animation
	if(finished):
		if event.is_action_pressed("game_action"):
			next_line()

func next_line():

	current_dialogue_index += 1
	finished = false
	#Only if we are in the initial dialogue we check if the lenght of it is higher than the current index
	if initial_dialogue:
		if(current_dialogue_index >= len(dialogues[0])):
			#var zone = get_tree().get_current_scene().name
			#var character = get_parent().name
			$Timer.start()
			$NinePatchRect.visible = false
			activate_movement()
			initial_dialogue = false
			emit_signal("finished_dialogue")
			return
		
	# If the dialogue is not the initial, ends when the only line is readed
	if(not initial_dialogue and (current_dialogue_index >= len(dialogues[1]))):
		$Timer.start()
		$NinePatchRect.visible = false
		activate_movement()
		return
	
	if dialogues[dialogue][current_dialogue_index]["name"] == "Option":
		var message = dialogues[dialogue][current_dialogue_index]["message"]
		var options = dialogues[dialogue][current_dialogue_index]["options"]
		# Deactivate the dialogue while desicion box is shown
		is_active = false
		$NinePatchRect.visible = false
		emit_signal("show_desicion", message, options)
	else:
		$NinePatchRect/name.text = dialogues[dialogue][current_dialogue_index]["name"]
		$NinePatchRect/message.text = dialogues[dialogue][current_dialogue_index]["message"]
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
		if character == "woman":
			player.set_animation("idle_woman")
		elif character == "elder":
			player.set_animation("idle_elder")
		
func activate_movement():
	var player = get_tree().get_root().find_node("player",true,false)
	if player:
		player.set_active(true)

func _on_Timer_timeout():
	is_active = false


func _on_Tween_tween_completed(object, key):
	finished = true


func _on_desicion_box_desicion_taken(next_dialogue):
	# Change dialogue according to desicion taken
	current_dialogue_index = next_dialogue -1
	next_line()
	is_active = true
	$NinePatchRect.visible = true

func _on_event_trigger2_guard_entered():
	play()
	show()

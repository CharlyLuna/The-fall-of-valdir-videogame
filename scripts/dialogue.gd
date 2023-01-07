extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_index = 0
var dialogue = 0
var is_active = false
var initial_dialogue = true
var finished = false
signal finished_z1_dialogue()
signal finished_z3_quest()
signal delivered_quest()
signal finished_dialogue()
signal dialogue_final_quest()
signal finished_game()
signal final_quest_accepted()
var character = Global.character

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
			var zone = get_tree().get_current_scene().name
			var character = get_parent().name
			$Timer.start()
			$NinePatchRect.visible = false
			activate_movement()
			initial_dialogue = false
			if zone == "Main":
				Global.finished_poor_dialogue = true
			if zone == "zone3" and Global.quest_completed == false and character == "knight_npc":
				Global.quest_completed = true
				emit_signal("finished_z3_quest")
			if zone == "zone2" and Global.quest_completed == true and character == "merchant_npc":
				emit_signal("delivered_quest")
			if zone == "zone2" and character == "captain_npc":
				Global.start_final_quest = true
			if zone == "zone3" and character == "princess_npc" and !Global.final_quest_accepted:
				Global.final_quest_accepted = true
				emit_signal("final_quest_accepted")
			if Global.final_quest_accepted and (character == "drunk_man_npc" || character == "barKeeper" || character == "poor_npc"):
				emit_signal("dialogue_final_quest")
			if zone == "zone3" and character == "princess_npc" and Global.final_quest_completed:
				emit_signal("finished_game")
			emit_signal("finished_dialogue")
			return
		
	# If the dialogue is not the initial, ends when the only line is readed
	if(not initial_dialogue and (current_dialogue_index >= len(dialogues[1]))):
		$Timer.start()
		$NinePatchRect.visible = false
		activate_movement()
		return
		
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

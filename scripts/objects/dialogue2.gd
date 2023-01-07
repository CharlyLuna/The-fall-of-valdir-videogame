extends CanvasLayer
#DEPRECATED, WILL NOT BE USED IN THE GAME
export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_index = 0
var dialogue = 0
var is_active = false
var initial_dialogue = true
var finished = false
export(int) var price
# variable to check if the player accepted the desicion
var desicion_accepted
signal dialogue_active()
signal dialogue_inactive()

func _ready():
	$NinePatchRect.visible = false

func play():
	# The dialog starts so you cant use play method again until the dialog ends
	if is_active:
		return
	dialogues = load_dialogue()
	
	is_active = true
	desactivate_movement()
	$NinePatchRect.visible = true
	
	# Reset the current index
	current_dialogue_index = -1
	# Check if the normal dialogue has finished and set the dialogue to the corresponding of the desicion
	if not initial_dialogue and dialogue <1:
		if(desicion_accepted):
			dialogue = 3
		else:
			dialogue = 1
	next_line()
	
# Detect when the user press the button for next dialogue line
func _input(event):
	# if the dialog isnt active then dont go to next line
	if not is_active:
		return
	# Go to the next line only if the current text has finished its animation
	if(finished):
		if Input.is_action_just_pressed("game_action"):
			next_line()

func next_line():
	print(dialogue)
	current_dialogue_index += 1
	finished = false
	#Only if we are in the initial dialogue we check if the lenght of it is higher than the current index
	if initial_dialogue:
		if(current_dialogue_index >= len(dialogues[0])):
			var desicion_box = get_parent().get_node("desicion_box")
			$NinePatchRect.visible = false
			initial_dialogue = false
			# Pass the price to show in the desicion box
			emit_signal("dialogue_inactive")
			desicion_box.play(price)
			is_active = false
			return
		
	if dialogue == 3 and (current_dialogue_index >= len(dialogues[dialogue])):
		$NinePatchRect.visible = false
		activate_movement()
		# is the final dialog so its no longer active
		$Timer.start()
		emit_signal("dialogue_inactive")
		# We active the action of the npc
		var npc = get_parent()
		npc.move()
		return
		
	if dialogue == 2:
		var desicion_box = get_parent().get_node("desicion_box")
		$NinePatchRect.visible = false
		activate_movement()
		desicion_box.play(price)
		return
		emit_signal("dialogue_inactive")
		
	if dialogue == 1 and (current_dialogue_index >= len(dialogues[dialogue])):
		$NinePatchRect.visible = false
		activate_movement()
		$Timer.start()
		emit_signal("dialogue_inactive")
		dialogue = 2
		return
		
	
	print(dialogues[dialogue][current_dialogue_index]["message"])
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
		
func activate_movement():
	var player = get_tree().get_root().find_node("player",true,false)
	if player:
		player.set_active(true)

func _on_Timer_timeout():
	is_active = false

func _on_Tween_tween_completed(object, key):
	finished = true


func _on_desicion_box_accepted_desicion(accepted):
	dialogue = 0
	desicion_accepted = accepted
	play()


func _on_Timer2_timeout():
	pass

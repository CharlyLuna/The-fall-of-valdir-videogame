extends Area2D

var entered = false
var finished_first_dialogue = Global.finished_poor_dialogue
var principal_character = Global.character
var final_quest = Global.final_quest_accepted


func _ready():
	if (!finished_first_dialogue || final_quest)and self.name == "poor_npc":
		$interactable_sign.show()

func _input(event):
	if event.is_action_pressed("game_action") and entered:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	var interactable = get_node_or_null("interactable_sign")
	
	if principal_character == "elder":
		dialogue.dialogue_file = "res://dialogues/principal_npc_dialogues_B.json"
	
	if finished_first_dialogue and self.name == "poor_npc":
		dialogue.dialogue_file = "res://dialogues/poor_npc_2_dialogue.json"
		
	if final_quest and self.name == "poor_npc":
		dialogue.dialogue_file = "res://dialogues/final_poor_npc.json"
	
	if dialogue:
		dialogue.play()
		$key_e.hide()
		if interactable:
			$interactable_sign.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_poor_npc_body_entered(body: PhysicsBody2D):
	$key_e.show()
	entered = true
	if !finished_first_dialogue and self.name == "poor_npc":
		var interactable = get_node_or_null("interactable_sign")
		if interactable:
			$interactable_sign.hide()

func _on_poor_npc_body_exited(body: PhysicsBody2D):
	$key_e.hide()
	entered = false
	if (!finished_first_dialogue || final_quest) and self.name == "poor_npc":
		var interactable = get_node_or_null("interactable_sign")
		if interactable:
			$interactable_sign.show()

extends Area2D

var entered = false
var first_dialogue = Global.first_talk_merchant
var finished_quest =false

func _ready():
	if Global.quest_completed == true:
		if not Global.final_quest_accepted:
			$interactable_sign.show()

func _input(event):
	if event.is_action_pressed("game_action") and entered and !first_dialogue:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	
	if Global.quest_completed == true:
		dialogue.dialogue_file = "res://dialogues/quest_completed.json"
	if Global.final_quest_accepted:
		return
	
	if dialogue:
		dialogue.play()
		$key_e.hide()

func _on_merchant_npc_body_entered(body):
	if body.get_collision_layer_bit(0):
		if first_dialogue:
				find_and_use_dialogue()
				Global.first_talk_merchant = false
				first_dialogue = false
		else:
			entered = true
			if not Global.final_quest_accepted:
				$key_e.show()
		$interactable_sign.hide()


func _on_merchant_npc_body_exited(body):
	$key_e.hide()
	entered = false
	$interactable_sign.hide()

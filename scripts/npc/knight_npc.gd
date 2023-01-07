extends Area2D

var entered = false
var finished_quest = Global.quest_completed

func _ready():
	if !finished_quest:
		$interactable_sign.show()

func _input(event):
	if event.is_action_pressed("game_action") and len(get_overlapping_bodies()) >0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	if finished_quest:
		dialogue.dialogue_file = "res://dialogues/knight_npc_2_dialogue.json"
	
	if dialogue:
		dialogue.play()
		$key_e.hide()

func _on_knight_npc_body_entered(body):
	$key_e.show()
	entered = true
	if !finished_quest:
		$interactable_sign.hide()


func _on_knight_npc_body_exited(body):
	$key_e.hide()
	entered = false
	if !finished_quest:
		$interactable_sign.show()


func _on_dialogue_finished_z3_quest():
	finished_quest = true
	Global.quest_completed = true
	$interactable_sign.hide()

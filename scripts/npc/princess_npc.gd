extends Area2D

var entered = false
var started_quest = Global.start_final_quest
var accepted = Global.final_quest_accepted
var finished_quest = Global.final_quest_completed
# Varible to detect if the quest has already be taked
var quest = false

func _ready():
	if started_quest || finished_quest:
		quest = false
		if !accepted || finished_quest:
			$interactable_sign.show()

func _input(event):
	if event.is_action_pressed("game_action") and len(get_overlapping_bodies()) >0 and (started_quest || finished_quest):
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	if finished_quest:
		dialogue.dialogue_file = "res://dialogues/final_lady_npc.json"
	
	if dialogue:
		dialogue.play()
		quest = true
		$key_e.hide()

func _on_princess_npc_body_entered(body):
	entered = true
	if started_quest || finished_quest:
		$key_e.show()
		$interactable_sign.hide()



func _on_princess_npc_body_exited(body):
	entered = false
	if started_quest || finished_quest:
		$key_e.hide()
		if !quest:
			$interactable_sign.show()

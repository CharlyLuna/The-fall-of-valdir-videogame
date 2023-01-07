extends Area2D

var entered = false
var final_quest = Global.final_quest_accepted

func _ready():
	if self.name == "drunk_man_npc" and final_quest:
		if !Global.final_quest_completed:
			$interactable_sign.show()

func _input(event):
	if event.is_action_pressed("game_action") and len(get_overlapping_bodies()) >0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	
	if self.name == "drunk_man_npc" and final_quest:
		dialogue.dialogue_file = "res://dialogues/final_drunk_npc.json"
	if self.name == "drunk_man_npc" and Global.final_quest_completed:
		dialogue.dialogue_file = "res://dialogues/drunk1_npc_dialogues.json"
	
	if dialogue:
		dialogue.play()
		$key_e.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_drunk_man_npc_body_entered(body):
	if self.name == "drunk_man_npc":
		$interactable_sign.hide()
	$key_e.show()
	entered = true


func _on_drunk_man_npc_body_exited(body):
	$key_e.hide()
	entered = false

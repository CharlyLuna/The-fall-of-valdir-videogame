extends Area2D

var entered = false
var principal_character = Global.character

func _input(event):
	if event.is_action_pressed("game_action") and len(get_overlapping_bodies()) >0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	if principal_character == "elder":
		dialogue.dialogue_file = "res://dialogues/villager2_npc_dialogues_B.json"
	
	if dialogue:
		dialogue.play()
		$key_e.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_villager2_npc_body_entered(body):
	$key_e.show()
	entered = true



func _on_villager2_npc_body_exited(body):
	$key_e.hide()
	entered = false


func _on_dialogue_finished_dialogue():
	$information.play("Flowers received")


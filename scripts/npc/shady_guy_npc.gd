extends Area2D

var entered = false
var is_in_desicion = false

func _input(event):
	if event.is_action_pressed("game_action") and len(get_overlapping_bodies()) >0 && !is_in_desicion:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("flexible_dialogues")
	
	if dialogue:
		dialogue.play()
		$key_e.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_shady_guy_npc_body_entered(body):
	$key_e.show()
	entered = true


func _on_shady_guy_npc_body_exited(body):
	$key_e.hide()
	entered = false


func _on_desicion_box_appeared():
	is_in_desicion = true


func _on_desicion_box_disappear():
	is_in_desicion = false

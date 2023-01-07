extends Area2D

var entered = false

func _input(event):
	if event.is_action_pressed("game_action") and len(get_overlapping_bodies()) >0:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	
	if dialogue:
		dialogue.play()
		$key_e.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_elder_npc_body_entered(body: PhysicsBody2D):
	$key_e.show()
	entered = true

func _on_elder_npc_body_exited(body: PhysicsBody2D):
	$key_e.hide()
	entered = false

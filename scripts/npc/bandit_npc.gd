extends Area2D

var entered = false

func _input(event):
	if event.is_action_pressed("game_action") and entered:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	
	if dialogue:
		dialogue.play()
		$key_e.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bandit_body_entered(body):
	$key_e.show()
	entered = true


func _on_Bandit_body_exited(body):
	$key_e.hide()
	entered = false

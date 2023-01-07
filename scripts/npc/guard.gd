extends Area2D

var entered = false
var first_dialogue = true
# Signal to indicate when the guard doesnt let you pass
signal guard_action()
var distracted = Global.guard_distracted

func _input(event):
	if event.is_action_pressed("game_action") and entered and !first_dialogue and !distracted:
		find_and_use_dialogue()
		
func find_and_use_dialogue():
	var dialogue = get_node_or_null("dialogue")
	
	if dialogue:
		dialogue.play()
		emit_signal("guard_action")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_guard_body_entered(body: PhysicsBody2D):
	if body.get_collision_layer_bit(0):
		if first_dialogue and !distracted:
			find_and_use_dialogue()
			first_dialogue = false
		else:
			entered = true
			# if the guard is distracted you canot interact with him
			if !distracted:
				$key_e.show()


func _on_guard_body_exited(body: PhysicsBody2D):
	if body.get_collision_layer_bit(0):
		$key_e.hide()
		entered = false



func _on_interactable_npc_distract():
	distracted = true
	$distracted_signal/AnimationPlayer.play("idle")
	$distracted_signal.show()

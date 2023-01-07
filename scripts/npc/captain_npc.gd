extends Area2D


var entered = false
var final_quest_started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func _input(event):
	if Input.is_action_just_pressed("game_action") and entered and final_quest_started:
			$dialogue.play()
			$key_e.hide()


func _on_captain_npc_body_entered(body):
	if body.get_collision_layer_bit(0):
		entered = true
		if final_quest_started:
			$interactable_sign.hide()
			$key_e.show()


func _on_captain_npc_body_exited(body):
	if body.get_collision_layer_bit(0):
		entered = false
		$key_e.hide()


func _on_zone2_started_final_quest():
	final_quest_started = true
	show()
	$interactable_sign.show()

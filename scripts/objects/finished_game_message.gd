extends Control


var end_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("game_action") and end_game:
		get_tree().change_scene("res://scenes/title_screen.tscn")


#func _on_dialogue_finished_z3_quest():
#	end_game = true
#	show()



func _on_Timer_timeout():
	var player = get_parent()
	player.set_active(false)
	player.set_animation("idle")
	end_game = true
	show()


func _on_dialogue_finished_game():
	$Timer.start()

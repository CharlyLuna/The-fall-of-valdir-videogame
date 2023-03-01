extends Control

export(String) var instruction_text
var quest_finished = Global.side_quest_finished

func _ready():
	if quest_finished:
		queue_free()
	else:
		hide()
		$ColorRect/enunciado.text = instruction_text


func _on_event_trigger3_side_mission_level_s():
	$instruction_time.start()
	show()


func _on_instruction_time_timeout():
	hide()
	queue_free()

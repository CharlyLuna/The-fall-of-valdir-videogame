extends RichTextLabel

var quest_finished = Global.final_quest_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func _on_Timer_timeout():
	hide()


func _on_dialogue_final_quest_accepted():
	if !quest_finished:
		$Timer.start()
		show()

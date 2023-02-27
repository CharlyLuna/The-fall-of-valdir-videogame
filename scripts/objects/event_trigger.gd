extends Area2D

signal bandit_girl_conversation()
var quest_finished = Global.side_quest_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	if quest_finished:
		queue_free()


func _on_event_trigger_body_entered(body):
	if body.get_collision_layer_bit(0):
		emit_signal("bandit_girl_conversation")
		queue_free()

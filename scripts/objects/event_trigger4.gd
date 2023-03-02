extends Area2D

signal child_has_gone()
var quest_finished = Global.side_quest_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	if quest_finished:
		queue_free()

func _on_event_trigger4_body_entered(body):
	if body.get_collision_layer_bit(3):
		emit_signal("child_has_gone")
		queue_free()

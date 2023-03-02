extends Area2D

signal side_mission_level_s()
var quest_finished = Global.side_quest_finished
var quest_started = Global.side_quest_started

# Called when the node enters the scene tree for the first time.
func _ready():
	if quest_finished || quest_started:
		queue_free()

func _on_event_trigger3_body_entered(body):
	if body.get_collision_layer_bit(3):
		Global.side_quest_started = true
		emit_signal("side_mission_level_s")
		queue_free()

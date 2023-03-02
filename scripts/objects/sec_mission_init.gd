extends Area2D

var quest_finished = Global.side_quest_finished
var quest_started = Global.side_quest_started
signal started_side_mission()

# Called when the node enters the scene tree for the first time.
func _ready():
	if quest_finished || quest_started:
		queue_free()

func _on_sec_mission_init_body_entered(body):
	if body.get_collision_layer_bit(0):
		emit_signal("started_side_mission")
		queue_free()

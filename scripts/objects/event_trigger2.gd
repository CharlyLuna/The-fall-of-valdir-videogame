extends Area2D

signal guard_entered()
var quest_finished = Global.side_quest_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	if quest_finished:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_event_trigger2_body_entered(body):
	if body.get_collision_layer_bit(3):
		emit_signal("guard_entered")
		queue_free()

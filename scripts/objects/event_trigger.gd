extends Area2D

signal bandit_girl_conversation()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_event_trigger_body_entered(body):
	if body.get_collision_layer_bit(0):
		emit_signal("bandit_girl_conversation")
		queue_free()

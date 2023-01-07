extends Area2D

var entered = false

# If the player enter the door he goes to other scene
func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("game_action"):
			Global.from_level = get_parent().name
			Global.guard_distracted = true
			Global.special_npc_active = false
			Global.gate_closed = false
			get_tree().change_scene("res://scenes/zone3.tscn")

# Detect when the player is in the area to interact with the door
func _on_zone3_body_entered(body: PhysicsBody2D):
	if body.get_collision_layer_bit(0):
		$key_e.show()
		entered = true

# Detect when the player out of the area to interact with the door
func _on_zone3_body_exited(body: PhysicsBody2D):
	if body.get_collision_layer_bit(0):
		$key_e.hide()
		entered = false

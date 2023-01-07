extends StaticBody2D


var enabled = Global.gate_closed


# Called when the node enters the scene tree for the first time.
func _ready():
	if !enabled:
		get_node("CollisionShape2D").disabled = true



#func _process(delta):
#	pass


func _on_interactable_npc_distract():
	get_node("CollisionShape2D").disabled = true

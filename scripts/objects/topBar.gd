extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$coins_value.text = str(Global.money)

#func _process(delta):
#	pass

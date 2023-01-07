extends Area2D

var life
var points = 0
var path = "res://saves/values.cfg"
var config = ConfigFile.new()
#var err = config.load(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if (body.get_name() == "player"):
		config.load(path)
		points = config.get_value("Values", "points", points)
		points += 1
		config.set_value("Values", "points", points)
		config.save(path)
		hide()
		get_node("../player").get_node("points").text = str("Coins: ", points)
		queue_free()

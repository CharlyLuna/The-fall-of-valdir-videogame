extends Node2D

var character

func _ready():
	character = "woman"

func move_down():
	character = "elder"
	position = Vector2(15,143)
	
func move_up():
	character = "woman"
	position = Vector2(15,74)

func _process(delta):
	Global.character = character

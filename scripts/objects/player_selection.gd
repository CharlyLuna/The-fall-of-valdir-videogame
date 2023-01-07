extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$box/arrow_selection/Sprite/AnimationPlayer.play("selector_animation_h")

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		$box/arrow_selection.move_down()
	elif Input.is_action_just_pressed("ui_up"):
		$box/arrow_selection.move_up()
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/controls_menu.tscn")

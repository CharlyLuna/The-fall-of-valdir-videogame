extends Node2D

func _ready():
	MusicController.play_music()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/player_selection.tscn")

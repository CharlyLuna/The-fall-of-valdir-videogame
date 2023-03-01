extends Control

export(String) var instruction_text

func _ready():
	hide()
	$ColorRect/enunciado.text = instruction_text

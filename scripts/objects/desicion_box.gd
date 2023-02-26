extends Control

signal desicion_taken(next_dialogue)
signal appeared()
signal disappear()
var is_visible
var possible_options

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func play(message, options):
	$enunciado.text = str(message)
	$opcion1.text = str(options[0].text)
	$opcion2.text = str(options[1].text)
	show()
	is_visible = true
	emit_signal("appeared")

func _input(event):
	if is_visible:
		if Input.is_action_just_pressed("choose_opt_1"):
			var next_line = possible_options[0].goes_to
			emit_signal("desicion_taken", next_line)
			hide()
			emit_signal("disappear")
			is_visible = false
		if Input.is_action_just_pressed("choose_opt_2"):
			var next_line = possible_options[1].goes_to
			emit_signal("desicion_taken", next_line)
			hide()
			emit_signal("disappear")
			is_visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_dialogue_show_desicion(message, options):
	possible_options = options
	play(message, options)

extends Control

signal accepted_desicion(accepted)
signal appeared()
signal disappear()
var is_visible

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func play(quantity):
	$enunciado.text = str("Pagar ", quantity," monedas")
	show()
	is_visible = true
	emit_signal("appeared")

func _input(event):
	if is_visible:
		if Input.is_action_just_pressed("accept"):
			emit_signal("accepted_desicion",true)
			hide()
			emit_signal("disappear")
			is_visible = false
		if Input.is_action_just_pressed("reject"):
			emit_signal("accepted_desicion",false)
			hide()
			emit_signal("disappear")
			is_visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

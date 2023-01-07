extends KinematicBody2D

const SPEED = 400
var velocity = Vector2()
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = SPEED * delta * direction
	$AnimatedSprite.play("attack")
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

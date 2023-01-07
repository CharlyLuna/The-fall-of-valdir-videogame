extends KinematicBody2D

export (int) var speed = 4500
var movement = Vector2()
var direction = 0
var collision
var entered
var on_action = false
# Variable to detect when we are in the middle of a desicion ITS DEPRECATED NOT USED ANY MORE
#var on_desicion = false
signal distract()
#Variable to see if the trigger action has already happened, in that case the player can interact with the npc
var talked_with_guard = false
var active = Global.special_npc_active

# Called when the node enters the scene tree for the first time.
func _ready():
	if !active:
		queue_free()
	
func move():
	direction = 1
	on_action = true

func _physics_process(delta):
	if direction != 0:
		movement = Vector2()
		collision = move_and_collide(movement * delta)
		
		# Stops at position to make its interaction
		if position.x > 1560:
			direction = 0
			$AnimatedSprite.animation = "dancing"
			emit_signal("distract")
			
		movement.x += direction
			
		if movement.length() > 0:
			movement = movement.normalized() * speed
		
		move_and_slide(movement * delta)

		if movement.x != 0:
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.flip_h = direction > 0

func _input(event):
	if Input.is_action_just_pressed("game_action") and entered and !on_action and talked_with_guard:
			$dialogue2.play()
			$key_e.hide()
		

func _on_Area2D_body_entered(body: PhysicsBody2D):
	if body.get_collision_layer_bit(0):
		entered = true
		if !on_action and talked_with_guard:
			$interactable_sign.hide()
			$key_e.show()


func _on_Area2D_body_exited(body: PhysicsBody2D):
	if body.get_collision_layer_bit(0):
		entered = false
		$key_e.hide()

func _on_guard_guard_action():
	talked_with_guard = true
	$interactable_sign.show()


## CODE DEPRECATED, WONT USE
#func _on_desicion_box_appeared():
#	on_desicion = true


#func _on_desicion_box_disappear():
#	on_desicion = false


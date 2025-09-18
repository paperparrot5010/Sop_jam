extends CharacterBody2D
var speed = 200
var gravity = 18
var jump_height = -300
func _physics_process(delta: float) -> void:
	#up and down :
	up_and_down()
	#right and left :
	movement()
	#Jumping:
	jump()
	move_and_slide()


func movement():
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else :
		velocity.x = 0
	pass
func up_and_down():
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		velocity.y = speed
	else :
		velocity.y = 0
func jump():

	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y += jump_height
	pass

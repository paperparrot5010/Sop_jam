extends CharacterBody2D
var bullet_path = preload("res://Player/bullet2.tscn")
var speed = 200

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		fire()
	var input_direction = Vector2.ZERO

	if Input.is_action_pressed("right"):
		input_direction.x += 1
	if Input.is_action_pressed("left"):
		input_direction.x -= 1
	if Input.is_action_pressed("down"):
		input_direction.y += 1
	if Input.is_action_pressed("up"):
		input_direction.y -= 1

	velocity = input_direction.normalized() * speed
	move_and_slide()
	



func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	bullet.rota = global_rotation
	get_parent().add_child(bullet)

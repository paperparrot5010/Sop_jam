extends CharacterBody2D
var bullet_path = preload("res://Player/bullet2.tscn")
var speed = 200
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:

	#look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		fire()
	var input_direction = Vector2.ZERO

	if Input.is_action_pressed("right"):
		input_direction.x += 1
		animated_sprite_2d.flip_h = false
	if Input.is_action_pressed("left"):
		
		input_direction.x -= 1
		animated_sprite_2d.flip_h = true

	if Input.is_action_pressed("down"):
		input_direction.y += 1
	if Input.is_action_pressed("up"):
		input_direction.y -= 1

	velocity = input_direction.normalized() * speed
	move_and_slide()
	if animated_sprite_2d.scale.x == 0.087 :
		animated_sprite_2d.scale.x = move_toward(0.087,0.051, 3 * delta)

	if animated_sprite_2d.scale.y == 0.087 :
		animated_sprite_2d.scale.y = move_toward(0.087,0.091, 3 * delta)

	if animated_sprite_2d.scale.y == 0.091 :
		animated_sprite_2d.scale.y = move_toward(0.091,0.087, 3 * delta)
	if animated_sprite_2d.scale.x == 0.091 :
		animated_sprite_2d.scale.x = move_toward(0.091,0.087, 3 * delta)





func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	bullet.rota = global_rotation
	get_parent().add_child(bullet)

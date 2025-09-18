extends CharacterBody2D

@export var speed = 100.0
@export var health = 1 # Example health
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player_node: Node2D = null
var crystal_scene = preload("res://Collectabel objects/crystal.tscn")

func _ready():
	player_node = get_tree().get_first_node_in_group("PlayerGroup")
	if player_node == null:
		print("Enemy AI: Error: Player node not found in \'PlayerGroup\'.")
		return
	else:
		print("Enemy AI: Player node found: ", player_node.name)

	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

func _physics_process(_delta: float) -> void:
	animated_sprite_2d.play("Run")

	if player_node.global_position.x < global_position.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	
	if player_node == null:
		return

	navigation_agent.target_position = player_node.global_position

	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

func take_damage(amount):
	health -= amount
	print("Enemy took ", amount, " damage. Health: ", health)
	if health <= 0:
		die()

func die():
	print("Enemy died!")
	drop_crystal()
	queue_free()

func drop_crystal():
	var crystal_instance = crystal_scene.instantiate()
	get_parent().add_child(crystal_instance)
	crystal_instance.global_position = global_position

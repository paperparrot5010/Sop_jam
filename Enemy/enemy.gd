extends CharacterBody2D

@export var speed = 100.0
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var player_node: Node2D = null

func _ready():
	# Find the player node. This assumes the player is named 'Player' in the scene.
	# You might need to adjust this if your player node has a different name or path.
	player_node = get_tree().get_first_node_in_group("PlayerGroup")
	if player_node == null:
		print("Enemy AI: Error: Player node not found in 'PlayerGroup'.")
		return
	else:
		print("Enemy AI: Player node found: ", player_node.name)

	# Set navigation agent properties (adjust as needed)
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

func _physics_process(delta: float) -> void:
	if player_node == null:
		return

	# Set the player's position as the target for the navigation agent
	navigation_agent.target_position = player_node.global_position
	# Debug: Print target position
	# print("Enemy AI: Target Position: ", navigation_agent.target_position)

	# If the navigation is finished (reached target or no path), do nothing
	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		# Debug: Print if navigation is finished
		# print("Enemy AI: Navigation Finished.")
		return

	# Get the next point on the path from the navigation agent
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	# Debug: Print next path position
	# print("Enemy AI: Next Path Position: ", next_path_position)

	# Calculate the direction to the next path point and move towards it
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

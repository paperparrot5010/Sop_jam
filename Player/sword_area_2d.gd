extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		animation_player.play("Hit")





func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("EnemyGroup"):
		if body.has_method("take_damage"):
			body.take_damage(1)

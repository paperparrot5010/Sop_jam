extends CharacterBody2D
@export var crystal_scene: PackedScene
var pos:Vector2
var rota:float
var dir:float
var speed = 2000

func _ready() -> void:
	global_position = pos
	global_rotation = rota
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(dir)
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("EnemyGroup"):
		var crystal = crystal_scene.instantiate()
		#crystal.position = .position
		body.queue_free()
		queue_free()
		
	elif body.is_in_group("MachineGroup") :
		queue_free()

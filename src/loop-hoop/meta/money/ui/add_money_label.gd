class_name AddMoneyLabel
extends Label3D

@export var lifetime: float = 1.0
@export var speed: float = 1.5

var elapsed_time: float

func _physics_process(delta: float) -> void:
	position += speed * Vector3.UP * delta
	elapsed_time += delta
	change_alpha(1 - elapsed_time)
	
	if elapsed_time > lifetime:
		queue_free()

func change_alpha(target: float) -> void:
	modulate.a = target
	outline_modulate.a = target

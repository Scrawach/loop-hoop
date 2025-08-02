class_name FloatingLabel3D
extends Label3D

@export var amplitude: float
@export var speed: float

var start_position: Vector3

func _ready() -> void: 
	start_position = global_position

func _physics_process(delta: float) -> void:
	var offset_y = amplitude * sin(Time.get_ticks_msec() * speed)
	global_position = start_position + Vector3(0, offset_y, 0)

class_name Present
extends Node3D

signal opened()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var open_pause: Timer = $"Open Pause"

func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and open_pause.is_stopped():
		open_pause.start()
		animation_player.play("open")

func _on_open_pause_timeout() -> void:
	opened.emit()

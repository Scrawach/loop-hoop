class_name Present
extends Node3D

signal start_opening()
signal opened()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var open_pause: Timer = $"Open Pause"
@onready var destroy: Timer = $Destroy
@onready var label_3d: FloatingLabel3D = $Label3D


func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_pressed() and open_pause.is_stopped():
		start_opening.emit()
		open_pause.start()
		animation_player.play("open")
		label_3d.hide()

func _on_open_pause_timeout() -> void:
	opened.emit()
	destroy.start()

func _on_destroy_timeout() -> void:
	queue_free()

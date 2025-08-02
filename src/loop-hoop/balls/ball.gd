class_name Ball
extends Node3D

const MINIMAL_DISTANCE: float = 0.1

@export var speed: float
@export var max_time: float

@export var current_tile: BasketTile
@export var target_tile: BasketTile

@export var field: BasketField

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var model: Node3D = $Model

var is_disabled: bool

var is_forward: bool = true
var start_position: Vector3
var target_position: Vector3
var progress: float = 0

func _physics_process(delta: float) -> void:
	if is_disabled:
		return
	
	if not current_tile and not target_tile:
		return
	
	if progress < max_time:
		move(start_position, target_position, delta)
	else:
		progress = 0
		take_next_target()
	
	animation_player.seek(animation_player.current_animation_length * progress)

func move(from: Vector3, to: Vector3, delta: float) -> void:
	progress += delta * speed
	global_position = from.lerp(to, progress / max_time)

func take_next_target() -> void:
	if field.is_should_change_direction(target_tile):
		is_forward = !is_forward
	
	current_tile = target_tile
	start_position = target_position
	
	current_tile.interact(self)
	
	target_tile = field.get_next_tile(current_tile, is_forward)
	target_position = target_tile.get_random_point()
	look_at(target_position, Vector3.UP, true)

func disable() -> void:
	is_disabled = true
	animation_player.play("RESET")
	

func enable() -> void:
	is_disabled = false
	animation_player.play("jump")

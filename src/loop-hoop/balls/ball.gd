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


var is_forward: bool = true
var progress: float = 0

func _process(delta: float) -> void:
	if not current_tile and not target_tile:
		return
	
	if not current_tile:
		take_next_target()
		return
	
	if progress < max_time:
		move(current_tile, target_tile, delta)
	else:
		progress = 0
		take_next_target()
	
	animation_player.seek(animation_player.current_animation_length * progress)

func move(from: BasketTile, to: BasketTile, delta: float) -> void:
	progress += delta * speed
	global_position = from.global_position.lerp(to.global_position, progress / max_time)

func take_next_target() -> void:
	if field.is_should_change_direction(target_tile):
		is_forward = !is_forward
	
	current_tile = target_tile
	current_tile.interact(self)
	target_tile = field.get_next_tile(current_tile, is_forward)
	look_at(target_tile.global_position, Vector3.UP, true)

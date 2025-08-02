class_name Ball
extends Node3D

const MINIMAL_DISTANCE: float = 0.1

@export var speed: float

@export var current_tile: BasketTile
@export var target_tile: BasketTile

@export var field: BasketField

var is_forward: bool = true
var progress: float = 0

func _process(delta: float) -> void:
	if not current_tile or not target_tile:
		return
	
	if progress < 1:
		move(current_tile, target_tile, delta)
	else:
		progress = 0
		take_next_target()

func move(from: BasketTile, to: BasketTile, delta: float) -> void:
	progress += delta * speed
	global_position = from.global_position.lerp(to.global_position, progress)

func take_next_target() -> void:
	if field.is_should_change_direction(target_tile):
		is_forward = !is_forward
	
	current_tile = target_tile
	current_tile.interact(self)
	target_tile = field.get_next_tile(current_tile, is_forward)

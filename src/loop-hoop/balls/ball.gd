class_name Ball
extends Node3D

@export var speed: float

@export var current_tile: BasketTile
@export var target_tile: BasketTile

@export var field: BasketField
@export var add_money_label: PackedScene

var is_forward: bool = true

func _process(delta: float) -> void:
	if not current_tile or not target_tile:
		return
	
	if not is_target_reached():
		move(current_tile, target_tile, delta)
	else:
		take_next_target()
		give_money()

func move(from: BasketTile, to: BasketTile, delta: float) -> void:
	var direction := (to.global_position - from.global_position).normalized()
	var movement := direction * speed * delta
	position += movement

func is_target_reached() -> bool:
	return (target_tile.global_position - global_position).length() < 0.2

func take_next_target() -> void:
	if field.is_should_change_direction(target_tile):
		is_forward = !is_forward
	
	current_tile = target_tile
	target_tile = field.get_next_tile(current_tile, is_forward)

func give_money() -> void:
	var instance := add_money_label.instantiate() as AddMoneyLabel
	get_parent().add_child(instance)
	instance.global_position = global_position + Vector3.UP
	Game.wallet.add_money(1)

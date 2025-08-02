class_name BasketField
extends Node3D

@export var rows: Array[Array]

func _ready() -> void:
	initialize_from_children()

func initialize_from_children() -> void:
	var index: int
	for child in get_children():
		for tile in child.get_children():
			var basket_tile: BasketTile = tile as BasketTile
			basket_tile.row_index = index
		rows.append(child.get_children())
		index += 1

func is_should_change_direction(from: BasketTile) -> bool:
	return from.row_index <= 0 or from.row_index >= rows.size() - 1

func get_next_tile(current: BasketTile, is_forward: bool) -> BasketTile:
	var target_index: int = current.row_index
	var next_step = 1 if is_forward else -1
	target_index += next_step
	return rows[target_index].pick_random()

@tool
class_name BasketTile
extends Node3D

@export var add_money_label: PackedScene

@export var has_hoop_circe: bool:
	set(value):
		has_hoop_circe = value
		$"tile-base/tile-hoop-circle".visible = value

@export_enum("none", "horizontal_forward", "horizontal_back") var horizontal_line: int:
	set(value):
		horizontal_line = value
		$"tile-base/tile-horizontal-line".visible = value == 1
		$"tile-base/tile-horizontal-line-2".visible = value == 2

@export_enum("none", "vertical_left", "vertical_right") var vertical_line: int:
	set(value):
		vertical_line = value
		$"tile-base/tile-vertical-line".visible = value == 1
		$"tile-base/tile-vertical-line-2".visible = value == 2

@export_enum("none", "0", "90", "180", "270") var angle_line: int:
	set(value):
		angle_line = value
		$"tile-base/tile-angle-line-0".visible = value == 1
		$"tile-base/tile-angle-line-90".visible = value == 2
		$"tile-base/tile-angle-line-180".visible = value == 3
		$"tile-base/tile-angle-line-270".visible = value == 4

var row_index: int

func interact(ball: Ball) -> void:
	give_money()

func give_money() -> void:
	var instance := add_money_label.instantiate() as AddMoneyLabel
	get_parent().add_child(instance)
	instance.global_position = global_position
	Game.wallet.add_money(1)

func get_random_point() -> Vector3:
	const MODEL_HALF_SIZE = Vector2(0.5, 0.3)
	var center := global_position
	var offset_x := randf_range(-MODEL_HALF_SIZE.x, MODEL_HALF_SIZE.x)
	var offset_z := randf_range(-MODEL_HALF_SIZE.y, MODEL_HALF_SIZE.y)
	return center + Vector3(offset_x, 0, offset_z)

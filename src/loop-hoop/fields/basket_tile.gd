class_name BasketTile
extends Node3D

@export var add_money_label: PackedScene

var row_index: int

func interact(ball: Ball) -> void:
	give_money()

func give_money() -> void:
	var instance := add_money_label.instantiate() as AddMoneyLabel
	get_parent().add_child(instance)
	instance.global_position = global_position
	Game.wallet.add_money(1)

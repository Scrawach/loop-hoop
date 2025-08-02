class_name Wallet
extends RefCounted

signal changed()

var money: int = 0

func add_money(count: int) -> void:
	money += count
	changed.emit()

func remove_money(count: int) -> void:
	money -= count
	changed.emit()

func has_enough_money(count: int) -> bool:
	return false

class_name MoneyUI
extends Control

@onready var money_label: Label = %"Money Label"


func _ready() -> void:
	Game.wallet.changed.connect(_on_money_changed)


func _on_money_changed() -> void:
	money_label.text = "%s.00" % Game.wallet.money

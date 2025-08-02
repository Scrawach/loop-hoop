class_name MoneyUI
extends Control

@onready var money_label: Label = %"Money Label"

var tween: Tween

func _ready() -> void:
	Game.wallet.changed.connect(_on_money_changed)


func _on_money_changed() -> void:
	if not visible:
		modulate.a = 0
		visible = true
		tween = create_tween()
		tween.tween_property(self, "modulate:a", 1.0, 1.0)
	
	money_label.text = "%s" % Game.wallet.money

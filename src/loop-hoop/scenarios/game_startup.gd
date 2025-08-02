class_name GameStartup
extends Node

@export var present: Present
@export var initial_ball: Ball

func _ready() -> void:
	initial_ball.disable()
	await present.opened
	initial_ball.enable()

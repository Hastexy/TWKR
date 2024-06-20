extends Node2D

@onready var player = $".."


func _on_endpoint_1_pressed():
	player.MovePlayer(Vector2i(-1, -2))


func _on_endpoint_2_pressed():
	player.MovePlayer(Vector2i(-2, -1))


func _on_endpoint_3_pressed():
	player.MovePlayer(Vector2i(-2, 1))


func _on_endpoint_4_pressed():
	player.MovePlayer(Vector2i(-1, 2))


func _on_endpoint_5_pressed():
	player.MovePlayer(Vector2i(1, 2))


func _on_endpoint_6_pressed():
	player.MovePlayer(Vector2i(2, 1))


func _on_endpoint_7_pressed():
	player.MovePlayer(Vector2i(2, -1))


func _on_endpoint_8_pressed():
	player.MovePlayer(Vector2i(1, -2))

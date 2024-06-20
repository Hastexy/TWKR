extends Node2D

@export var generation_size : Vector2 = Vector2(5, 3)

const ROOM = preload("res://Scenes/Rooms/Board2.tscn")
var room_size = Vector2i(324, 180)

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap_array_x = []
	for x in generation_size.x:
		var tilemap_array_y = []
		for y in generation_size.y:
			var r = ROOM.instantiate()
			
			r.position.x = x * room_size.x
			r.position.y = y * room_size.y
			add_child(r)
		tilemap_array_x.append(tilemap_array_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

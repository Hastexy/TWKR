extends Node2D

@export var generation_size : Vector2 = Vector2(5, 3)

@export var room_list = ["res://Scenes/Rooms/Room1.tscn", "res://Scenes/Rooms/Room2.tscn"]
var room_size = Vector2i(324, 180)

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap_array_x = []
	for x in generation_size.x:
		var tilemap_array_y = []
		for y in generation_size.y:
			var random_room = load(room_list.pick_random())
			var r = random_room.instantiate()
			
			r.position.x = x * room_size.x
			r.position.y = y * room_size.y
			add_child(r)
		tilemap_array_x.append(tilemap_array_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node2D

@export var room_list = ["res://Scenes/Rooms/Room1.tscn", "res://Scenes/Rooms/Room2.tscn"]
var room_size = Vector2i(324, 180)
var room_count = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	var current_room = Vector2i(0,0)
	var tilemap_array = []
	for i in room_count:
		tilemap_array.append([])
		for j in room_count:
			tilemap_array[i].append(false)
	var random_room = load("res://Scenes/Rooms/Room1.tscn")
	while room_count > 0:
		var r = random_room.instantiate()
		r.position.x = current_room.x * room_size.x
		r.position.y = current_room.y * room_size.y
		add_child(r)
		tilemap_array[current_room.x][current_room.y] = true
		room_count -= 1
		current_room = Vector2i(0,0)
		while tilemap_array[current_room.x][current_room.y] == true:
			current_room += [Vector2i(0,1),Vector2i(1,0),Vector2i(0,-1),Vector2i(-1,0)].pick_random()
		random_room = load(room_list.pick_random())
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

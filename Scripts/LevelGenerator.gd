extends Node2D

@export var room_list = ["res://Scenes/Rooms/Room1.tscn", "res://Scenes/Rooms/Room2.tscn"]
@export var enemy_list = ["res://Scenes/Pawn.tscn"]
var room_size = Vector2i(324, 180)
var room_count = 15
var enemy_count = [0, 1, 1, 1, 2, 2, 3]

@onready var rooms = $Rooms

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
		rooms.add_child(r)
		tilemap_array[current_room.x][current_room.y] = true
		room_count -= 1
		current_room = Vector2i(0,0)
		while tilemap_array[current_room.x][current_room.y] == true:
			current_room += [Vector2i(0,1),Vector2i(1,0),Vector2i(0,-1),Vector2i(-1,0)].pick_random()
		random_room = load(room_list.pick_random())
	SpawnEnemies()
	pass
		
func SpawnEnemies():
	var room_nodes = rooms.get_children()
	for room in room_nodes:
		var enemy_node = Node2D.new()
		enemy_node.name = "Enemies"
		room.add_child(enemy_node)
		
		var spawns = enemy_count.pick_random()
		var spawnable_tiles = room.get_child(0).get_used_cells(0)
		for i in spawns:
			var random_enemy = load(enemy_list.pick_random()).instantiate()
			enemy_node.add_child(random_enemy)
			var tile = spawnable_tiles.pick_random()
			random_enemy.pos = tile
			random_enemy.position = random_enemy.pos*18
	pass
		
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

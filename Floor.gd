extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dothing():
	var walkable_tiles = get_used_cells(-1)
	print(walkable_tiles)
	print(map_to_local(walkable_tiles[99]))

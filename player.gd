extends Node

@export var floor_tilemap: TileMap
@export var player: Node2D
@export var selected_tile: Sprite2D
@export var endpoints: Node2D
var moves = 3
var legal_moves = [2,2,2,2]
var walkable_tiles
var pos = Vector2i(0,0)
var move_selected = false
var move_index = 0
var endpoints_list

func _ready():
	player.position = Vector2i(9,9)
	walkable_tiles = floor_tilemap.get_used_cells(0)
	IndicateMoves()
	DrawEndpoints()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DrawSelect()
	SelectMove()
	if move_selected:
		IndicateMoves()
		DrawEndpoints()
	
func DrawSelect():
	selected_tile.position = player.position + Vector2(endpoints_list[move_index].x, endpoints_list[move_index].y)*18
	
func DrawEndpoints():
	for child in endpoints.get_children():
		endpoints.remove_child(child)
	print(endpoints.get_children())
	for point in endpoints_list:
		var tile = selected_tile.duplicate()
		tile.position = player.position + Vector2(point.x, point.y)*18
		tile.modulate.a8 = 75
		endpoints.add_child(tile)
		
	
func IndicateMoves():
	endpoints_list = GetEndpoints()
	if move_index >= endpoints_list.size():
		move_index = 0
	move_selected = false
	
func SelectMove():
	var cur_move = endpoints_list[move_index]
	if Input.is_action_just_pressed("Move Right"):
		move_index += 1
		if move_index == endpoints_list.size():
			move_index = 0
		cur_move = endpoints_list[move_index]
	elif Input.is_action_just_pressed("Move Left"):
		move_index -= 1
		if move_index == -1:
			move_index = endpoints_list.size() - 1
		cur_move = endpoints_list[move_index]
	elif Input.is_action_just_pressed("Select"):
		player.position += Vector2(cur_move.x, cur_move.y)*18
		pos += cur_move
		move_selected = true
	
func GetEndpoints():
	var endpoint_base = [Vector2i(1,-2), Vector2i(2,-1), Vector2i(2,1), Vector2i(1,2), Vector2i(-1,2), Vector2i(-2,1), Vector2i(-2,-1), Vector2i(-1,-2)]
	var inbound_endpoints = []
	for endpoint in endpoint_base:
		var new_point = pos + endpoint
		if new_point in walkable_tiles:
			inbound_endpoints.append(endpoint)
	return inbound_endpoints

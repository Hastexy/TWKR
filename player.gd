extends Node

@export var floor_tilemap: TileMap
@export var player: Node2D
@export var selected_tile: Sprite2D
var moves = 3
var legal_moves = [2,2,2,2]
var walkable_tiles
var pos = Vector2i(0,0)
var move_selected = false
var move_index = 0
var endpoints

func _ready():
	player.position = Vector2i(9,9)
	walkable_tiles = floor_tilemap.get_used_cells(0)
	IndicateMoves()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DrawIndicators()
	SelectMove()
	if move_selected:
		IndicateMoves()
	
func DrawIndicators():
	selected_tile.position = player.position + Vector2(endpoints[move_index].x, endpoints[move_index].y)*18
	
func IndicateMoves():
	endpoints = GetEndpoints()
	if move_index >= endpoints.size():
		move_index = 0
	move_selected = false
	
func SelectMove():
	var cur_move = endpoints[move_index]
	if Input.is_action_just_pressed("Move Right"):
		move_index += 1
		if move_index == endpoints.size():
			move_index = 0
		cur_move = endpoints[move_index]
	elif Input.is_action_just_pressed("Move Left"):
		move_index -= 1
		if move_index == -1:
			move_index = endpoints.size()
		cur_move = endpoints[move_index]
	elif Input.is_action_just_pressed("Select"):
		player.position += Vector2(cur_move.x, cur_move.y)*18
		pos += cur_move
		move_selected = true
		
func EditMoves(curside, opposite, other, oppositeother, transform):
	moves -= 1
	legal_moves[curside] -= 1
	legal_moves[opposite] = 0
	if (legal_moves[other] == 1 or legal_moves[oppositeother] == 1):
		legal_moves[other] = 0
		legal_moves[oppositeother] = 0
	var x = player.position.x + transform.x
	var y = player.position.y + transform.y
	player.position = Vector2i(x,y)
	pos += transform/18
	
func GetEndpoints():
	var endpoint_base = [Vector2i(1,-2), Vector2i(2,-1), Vector2i(2,1), Vector2i(1,2), Vector2i(-1,2), Vector2i(-2,1), Vector2i(-2,-1), Vector2i(-1,-2)]
	var inbound_endpoints = []
	for endpoint in endpoint_base:
		var new_point = pos + endpoint
		if new_point in walkable_tiles:
			inbound_endpoints.append(endpoint)
	return inbound_endpoints

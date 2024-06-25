extends Node

var move = 1
var walkable_tiles
var pos
var time = 0
var attacking = false

@onready var enemy_collider = $EnemyCollider
@onready var movement_endpoints = $"Movement Colliders"
@onready var killing_endpoints = $"Killing Colliders"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pass
	
func _process(delta):
	time += delta
	if time >= 1.0:
		var next = getNextMove()
		MoveEnemy(next)
		time = 0
		
func getNextMove():
	#Check if you can kill player
	var endpoints = killing_endpoints.get_children()
	for endpoint : Area2D in endpoints:
		var overlap_areas = endpoint.get_overlapping_areas() != []
		var overlap_player = false
		if overlap_areas:
			overlap_player = endpoint.get_overlapping_areas()[0].name == "PlayerArea"
		if overlap_player:
			attacking = true
			return endpoint.get_meta("Direction")
			
	#If enemy can't kill player, just move randomly
	var valid_endpoints = []
	endpoints = movement_endpoints.get_children()
	for endpoint : Area2D in endpoints:
		var in_bounds = endpoint.get_overlapping_bodies() != []
		var overlap_areas = endpoint.get_overlapping_areas() != []
		var overlap_player
		if overlap_areas:
			print(endpoint.get_overlapping_areas()[0].name)
			overlap_player = endpoint.get_overlapping_areas()[0].name == "PlayerArea"
		if in_bounds and not overlap_player:
			valid_endpoints.append(endpoint)
	var endpoint = valid_endpoints.pick_random()
	return endpoint.get_meta("Direction")
	
	
func MoveEnemy(movement : Vector2i):
	pos += movement 
	var enemy_movement_tween = create_tween()
	enemy_movement_tween.tween_property(self, "position", Vector2(pos * 18), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await enemy_movement_tween.finished
	await get_tree().create_timer(0.1).timeout
	attacking = !enemy_movement_tween.finished


func _on_enemy_collider_area_entered(area : Area2D):
	if area.name != "PlayerArea": return
	var player : Sprite2D = area.get_parent()
	if attacking:
		player.texture = null
		player.dead = true
	else:
		self.get_parent().remove_child(self)
		self.queue_free()

extends Node

var move = 1
var walkable_tiles
var pos = Vector2i(1,1)
var time = 0
var enemy_collider
var attacking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	self.position = pos * 18
	enemy_collider = $EnemyCollider
	
	
func _process(delta):
	time += delta
	if time >= 1.0:
		attacking = true
		var next = getNextMove()
		MoveEnemy(next)
		time = 0
		
func getNextMove():
	move *= -1
	return Vector2i(0, move)
	
	
func MoveEnemy(movement : Vector2i):
	pos += movement
	var enemy_movement_tween = create_tween()
	enemy_movement_tween.tween_property(self, "global_position", Vector2(pos * 18), 0.1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
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

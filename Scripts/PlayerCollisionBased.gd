extends Sprite2D

@onready var endpoints = $Endpoints
var board_pos : Vector2i = Vector2i(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Select"):
		HideInvalidEndpoints()



func MovePlayer(movement : Vector2i):
	board_pos += movement
	
	var player_movement_tween = create_tween()
	player_movement_tween.tween_property(self, "global_position", Vector2(board_pos * 18), 0.1)
	HideAllEndpoints()
	await player_movement_tween.finished
	await get_tree().create_timer(0.1).timeout
	HideInvalidEndpoints()


func HideAllEndpoints():
	for i in endpoints.get_children(): 
		i.visible = false


func HideInvalidEndpoints():
	for i in endpoints.get_children(): 
		i.visible = true #Reset endpoint visibility
		if CheckEndpointValidity(i) == false: #Make endpoints that collide with border wall invisible
			i.visible = false


func CheckEndpointValidity(endpoint):
	if endpoint.get_child(0).get_overlapping_bodies() == []:
		return true
	return false




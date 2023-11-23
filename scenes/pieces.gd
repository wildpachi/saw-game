extends Node2D

@export var rows : int = 3
@export var columns : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var piece_scene = preload("res://scenes/piece/piece.tscn")
		
	var locations = range(0, rows*columns,1)
	randomize()
	locations.shuffle()
		
	for i in range(0,rows*columns,1):
		var piece = piece_scene.instantiate()
		var x = fmod(i, columns)
		var y = i / columns
		
		piece.value = locations[i]
		piece.position = Vector2(72 * x + 500, 72 * y + 100)
		piece.add_to_group('pieces')
		%PieceSpawn.add_child(piece)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

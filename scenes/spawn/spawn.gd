extends Node2D
class_name PuzzleSpawn

@export var type : Global.SpawnType
@export var canvas : PuzzleCanvas

var spread : Vector2 = Vector2(0,0)
var scene : PackedScene = null
var shuffle : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		Global.SpawnType.SLOT:
			scene = preload("res://scenes/slot/slot.tscn")
			shuffle = false
		Global.SpawnType.PIECE:
			scene = preload("res://scenes/piece/piece.tscn")
			shuffle = true
			spread = Vector2(25, 10)
	
	if scene:
		var locations = range(0, canvas.piece_count,1)
		randomize()
		locations.shuffle()
		
		var offsetH = -int((canvas.piece_size + spread.x) * float(canvas.piece_count_col / 2))
		var offsetV = -int((canvas.piece_size + spread.y) * float(canvas.piece_count_row / 2))
			
		for i in range(0,canvas.piece_count,1):
			var child = scene.instantiate()			
			var index = locations[i] if shuffle else i
			child.index = index
			child.position = canvas.get_start_location_at_index(i,0) - Vector2i(canvas.puzzle_width_adj/2, canvas.puzzle_height_adj/2)
			
			if type == Global.SpawnType.PIECE:
				child.puzzle_image = canvas.get_image_at_index(index, 0)
				child.position = canvas.get_random_global_location_in_rect(get_viewport().get_visible_rect()) - Vector2i(canvas.puzzle_width_adj/1.5, canvas.puzzle_height_adj/1.5)
			
			self.add_child(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

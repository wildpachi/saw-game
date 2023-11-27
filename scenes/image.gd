extends Control
class_name PuzzleCanvas

@export var puzzle_image : Image

var piece_size : int = 100
var piece_count : int
var piece_count_row : int
var piece_count_col : int

var puzzle_height : int
var puzzle_width : int

# Called when the node enters the scene tree for the first time.
func _ready():
	puzzle_height = puzzle_image.get_height()
	puzzle_width = puzzle_image.get_width()
	
	piece_count_row = puzzle_height / piece_size
	piece_count_col = puzzle_height / piece_size
	piece_count = piece_count_col * piece_count_row
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_image_at_index(index : int, spread : int) -> Image:
	var start = get_start_location_at_index(index, spread)
	var spread_size = piece_size + (2*spread)
	return puzzle_image.get_region( Rect2i(start, Vector2i(spread_size,spread_size)) ) 

func get_start_location_at_index(index: int, spread: int) -> Vector2i:
	var y = index / piece_count_row
	var x = fmod(index, piece_count_row)
	return Vector2i((piece_size * x) - spread, (piece_size * y) - spread)

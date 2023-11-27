extends Control
class_name PuzzleCanvas

@export var puzzle_image : Image

var piece_size : int = 72
var piece_count : int
var piece_count_row : int
var piece_count_col : int

var puzzle_height : int
var puzzle_width : int
var puzzle_height_adj : int
var puzzle_width_adj : int

# Called when the node enters the scene tree for the first time.
func _ready():
	puzzle_image = Image.new()
	puzzle_image.load("res://assets/test-image.jpg")
	
	if puzzle_image:
		puzzle_height = puzzle_image.get_height()
		puzzle_width = puzzle_image.get_width()
		
		piece_count_row = puzzle_width / piece_size
		piece_count_col = puzzle_height / piece_size
		piece_count = piece_count_col * piece_count_row
		
		puzzle_height_adj = piece_count_col * piece_size
		puzzle_width_adj = piece_count_row * piece_size
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
	
func get_random_global_location_in_rect(area : Rect2i) -> Vector2i:
	var x = (randi_range(area.position.x, area.end.x))
	var y = (randi_range(area.position.y, area.end.y))
	return Vector2i(x,y)

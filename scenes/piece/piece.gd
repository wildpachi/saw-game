extends Node2D
class_name Piece

signal score_point()

@export var index : int
@export var image : Image

# Called when the node enters the scene tree for the first time.
func _ready():
	%PieceLabel.text = str(index)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var movement = $Movement
	if movement.can_drag:
		if movement.is_picked_up:
			if movement.mouse_position:
				global_position = get_global_mouse_position() - movement.mouse_position
			if Input.is_action_just_pressed("mouse_click"):
				movement.drop()
			if Input.is_action_just_released("mouse_click"):
				if movement.can_drop_on_release:
					movement.drop()
		elif Input.is_action_just_pressed("mouse_click"):
			movement.pickup()

func init_movement():
	pass

#Spawn Functions
func spawn_set_location(spawn_area : Rect2i):
	pass # Pick a random location within given rectangle

func spawn_set_image():
	pass # Crop image based on piece index

func _on_movement_score_point():
	score_point.emit()

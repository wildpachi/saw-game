extends Node2D

signal correct

@export var value = 0

var locked = false
var draggable = false
var selected = false
var mousePos = null
var holePosition
var inPosition = false

# Called when the node enters the scene tree for the first time.
func _ready():
	%PieceLabel.text = str(value)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if not locked:
		if draggable:
			if Input.is_action_just_pressed("mouse_click"):
				Global.is_dragging = true
			if Input.is_action_just_pressed("mouse_click"):
				mousePos = get_global_mouse_position() - global_position
				selected = true
				z_index = 100
			if Input.is_action_pressed("mouse_click"):
				if mousePos:
					global_position = get_global_mouse_position() - mousePos
			elif Input.is_action_just_released("mouse_click"):
				Global.is_dragging = false
				selected = false
				if inPosition:
					if holePosition is Hole:
						var tween = get_tree().create_tween()
						tween.tween_property(self, "position", holePosition.position, 0.2).set_ease(Tween.EASE_OUT)
						holePosition.modulate = Color(Color.GREEN, 1)
						locked = true
						correct.emit()

func _on_mouse_area_mouse_entered():
	if not Global.is_dragging:
		draggable = true

func _on_mouse_area_mouse_exited():
	if not selected:
		draggable = false

func _on_snap_area_body_entered(body):
	if body is Hole:
		if body.is_in_group('holes'):
			if body.value == value:
				inPosition = true
				holePosition = body

func _on_snap_area_body_exited(body):
	inPosition = false
	holePosition = null

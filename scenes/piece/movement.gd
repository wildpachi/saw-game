extends Node2D
class_name MoveController

signal score_point()

var index : int

var can_drag : bool = false
var can_snap : bool = false
var can_drop_on_release : bool = false

var is_picked_up : bool = false

var mouse_position : Vector2 = Vector2.ZERO

@export var piece_body : Node2D = null
var collision_body : Node2D = null

func _ready():
	index = piece_body.index

func _process(delta):
	if not Global.is_dragging:
		if $MouseArea.has_overlapping_areas():
			piece_body.global_position = piece_body.global_position.move_toward($MouseArea.get_overlapping_areas()[0].global_position, -1.0)

#Movement Functions
func pickup():
	Global.is_dragging = true
	is_picked_up = true
	can_drop_on_release = false
	z_index = 2
	mouse_position = get_global_mouse_position() - global_position
	%PickupTimer.start()
	
func drop():
	is_picked_up = false
	Global.is_dragging = false
	if can_snap:
		if collision_body is Slot:
			drop_snap()
			drop_score()

func drop_snap():
	var tween = get_tree().create_tween()
	tween.tween_property(piece_body, "position", collision_body.position, 0.1).set_ease(Tween.EASE_OUT)
	collision_body.modulate = Color(Color.GREEN, 1)

func drop_score():
	z_index = 0
	$MouseArea/MouseCollision.disabled = true
	$SnapArea/SnapCollision.disabled = true
	score_point.emit()

#Signal Handling
func _on_mouse_area_mouse_entered():
	if not Global.is_dragging:
		can_drag = true

func _on_mouse_area_mouse_exited():
	if not is_picked_up:
		can_drag = false

func _on_snap_area_body_entered(body):
	if body is Slot:
		if body.is_in_group('slots'):
			if body.index == index:
				can_snap = true
				collision_body = body

func _on_snap_area_body_exited(body):
	can_snap = false
	collision_body = null

func _on_pickup_timer_timeout():
	if is_picked_up:
		can_drop_on_release = true

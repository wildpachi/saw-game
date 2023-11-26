extends Node2D
class_name Piece

signal score_point()

@export var index : int
@export var image : Image

var can_drag : bool = false
var can_snap : bool = false
var can_drop_on_release : bool = false

var is_picked_up : bool = false

var mouse_position : Vector2 = Vector2.ZERO
var collision_body : Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	%PieceLabel.text = str(index)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if can_drag:
		if is_picked_up:
			if mouse_position:
				global_position = get_global_mouse_position() - mouse_position
			if Input.is_action_just_pressed("mouse_click"):
				drop()
			if Input.is_action_just_released("mouse_click"):
				if can_drop_on_release:
					drop()
		elif Input.is_action_just_pressed("mouse_click"):
			mouse_position = pick_up()

#Functions
func pick_up():
	Global.is_dragging = true
	is_picked_up = true
	can_drop_on_release = false
	var start_position = get_global_mouse_position() - global_position
	%PickupTimer.start()
	return start_position
	
func drop():
	is_picked_up = false
	Global.is_dragging = false
	if can_snap:
		if collision_body is Slot:
			snap()
			score()

func snap():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", collision_body.position, 0.1).set_ease(Tween.EASE_OUT)
	collision_body.modulate = Color(Color.GREEN, 1)

func score():
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
		if body.is_in_group('holes'):
			if body.index == index:
				can_snap = true
				collision_body = body

func _on_snap_area_body_exited(body):
	can_snap = false
	collision_body = null

func _on_pickup_timer_timeout():
	if is_picked_up:
		can_drop_on_release = true

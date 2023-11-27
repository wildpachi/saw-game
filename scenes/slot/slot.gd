extends StaticBody2D
class_name PuzzleSlot

@export var index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	%SlotLabel.text = str(index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

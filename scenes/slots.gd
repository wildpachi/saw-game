extends Node2D

@export var rows : int = 3
@export var columns : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	var slot_scene = preload("res://scenes/slot/slot.tscn")
		
	var locations = range(0, rows*columns,1)
	randomize()
	locations.shuffle()
		
	for i in range(0,rows*columns,1):
		var slot = slot_scene.instantiate()
		var x = fmod(i, columns)
		var y = i / columns
		
		slot.value = i
		slot.position = Vector2(72 * x + 100, 72 * y + 100)
		%SlotSpawn.add_child(slot)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

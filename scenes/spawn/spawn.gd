extends Node2D

@export var type : int
@export var rows : int = 3
@export var columns : int = 3

@export var size : int = 72

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
			spread = Vector2(50, 25)
	
	if scene:
		var locations = range(0, rows*columns,1)
		randomize()
		locations.shuffle()
		
		var offsetH = -int((size + spread.x) * float(columns / 2))
		var offsetV = -int((size + spread.y) * float(rows / 2))
			
		for i in range(0,rows*columns,1):
			var child = scene.instantiate()
			var x = fmod(i, columns)
			var y = i / columns
			
			child.value = locations[i] if shuffle else i
			child.position = Vector2(((size + spread.x) * x) + offsetH, ((size + spread.y) * y) + offsetV)
			self.add_child(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

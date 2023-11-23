extends Node

var pieceSize = 200
var piecesX : int
var piecesY : int

var puzzleWidth : int = 1600
var puzzleHeight : int = 900

# Called when the node enters the scene tree for the first time.
func _ready():
	if %PuzzleTexture.texture:
		puzzleWidth = %PuzzleTexture.texture.get_width()
		puzzleHeight = %PuzzleTexture.texture.get_height()
	
	piecesX = puzzleWidth / pieceSize
	piecesY = puzzleHeight / pieceSize
	$PuzzleSize.text = str(piecesX) + " x " + str(piecesY) 
	
	var spawn_scene = preload("res://scenes/spawn/spawn.tscn")
	$PuzzleSpawnLocation.add_child(create_spawn(spawn_scene, Global.SpawnType.SLOT))
	$PuzzleSpawnLocation.add_child(create_spawn(spawn_scene, Global.SpawnType.PIECE))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func create_spawn(scene, type):
	var spawn = scene.instantiate()
	spawn.type = type
	spawn.columns = piecesX
	spawn.rows = piecesY
	return spawn

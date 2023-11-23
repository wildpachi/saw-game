extends Node

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var p = get_tree().get_nodes_in_group("pieces")
	for i in p:
		i.connect("correct", Callable(self, "inc_score"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Label.text = str(score)

func inc_score():
	score += 1

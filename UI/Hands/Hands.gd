extends Node2D

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hand scale: ", scale)

func get_width():
	return 180*scale.x

func get_handCntr():
	var x = 96.0*scale.x
	var y = 184.0*scale.y
	return Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

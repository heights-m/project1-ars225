extends Area2D

@onready var creation_animation = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	creation_animation.play("start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

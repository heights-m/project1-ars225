extends Area2D

@onready var items_sprite = $AnimatedSprite2D
var selected = false
var origin = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	items_sprite.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("MouseClick"):
		selected = true
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = origin
		
func _input(event):
	if event.is_action("MouseClick") and not event.is_pressed():
		selected = false
		
		


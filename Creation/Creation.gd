extends Area2D

@onready var creation_animation = $AnimatedSprite2D
var item_entered = false
var item

# Called when the node enters the scene tree for the first time.
func _ready():
	creation_animation.play("start")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_entered && !item.selected:
			print("dropped")
			


func _on_area_entered(area):
	item_entered = true;
	item = area
	var sig_name = area_entered.get_name()
	print(sig_name, " ", area.items_sprite.frame)
	


func _on_area_exited(area):
	item_entered = false

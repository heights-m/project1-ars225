extends Area2D

@onready var bg_sprite = $AnimatedSprite2D
var item_entered = false
var item
var dict = {0: {0: 1}
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_sprite.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_entered && !item.selected:
			print("bg dropped")
			item_entered =  false

func _on_area_entered(area):
	item = area
	if item.selected:
		item_entered = true;
		var sig_name = area_entered.get_name()
		print("bg", sig_name, " ", area.items_sprite.frame)

func _on_area_exited(area):
	item_entered = false

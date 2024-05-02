extends Area2D

@onready var creation_animation = $AnimatedSprite2D
var item_entered = false
var item
var rgb_sel = 0
var rgb = [0.5, 0, 0]

var dict = {"start": {0: "bubble", 1: "soul"}
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	creation_animation.play("start")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_entered && !item.selected:
			print("dropped")
			item_entered =  false
	if creation_animation.animation == "start":
		color_shift()


func _on_area_entered(area):
	item_entered = true;
	item = area
	var sig_name = area_entered.get_name()
	print(sig_name, " ", area.items_sprite.frame)

func _on_area_exited(area):
	item_entered = false

func color_incr(x, y):
	rgb[x] += 0.001
	rgb[y] -= 0.001
	
func color_shift():
	match rgb_sel:
		0:
			if rgb[0] >= 0.5:
				rgb_sel = 1
			else:
				color_incr(0, 2)
		1: 
			if rgb[1] >= 0.5:
				rgb_sel = 2
			else:
				color_incr(1, 0)
		2: 
			if rgb[2] >= 0.5:
				rgb_sel = 0
			else:
				color_incr(2, 1)
	creation_animation.modulate = Color(rgb[0], rgb[1], rgb[2], 1)


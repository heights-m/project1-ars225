extends Area2D

@onready var bg_sprite = $AnimatedSprite2D
var item_entered = false
var item
var f
enum iType {W = 0, H = 1, L = 2, B = 3}
var dict = {0: {iType.W: 1, iType.H: 2, iType.L: 3, iType.B: 4}, 1: {iType.W: -1, iType.H: -1, iType.L: 3, iType.B: -1}, 2: {iType.W: -1, iType.H: 6, iType.L: 5, iType.B: 7},
			3: {iType.W: -1, iType.H: -1, iType.L: -1, iType.B: 4}, 4: {iType.W: -1, iType.H: -1, iType.L: -1, iType.B: 8}, 5: {iType.W: -1, iType.H: 6, iType.L: -1, iType.B: 8},
			6: {iType.W: -1, iType.H: 7, iType.L: 2, iType.B: 7}, 7: {iType.W: -1, iType.H: -1, iType.L: 5, iType.B: 8}, 8: {iType.W: -1, iType.H: 7, iType.L: 5, iType.B: -1}}
var bg_dict = {1: ["ocean", false], 2: ["purpose", false], 3: ["fields", false], 4: ["warmth inside", false],
				5: ["heaven", false], 6: ["reflection", false], 7: ["broken", false], 8: ["hell", false]}

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_sprite.frame = 0
	f = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_entered && !item.selected && !item.iscreation:
			print("bg dropped")
			item_entered =  false
			change_bg(item.f)
	do_popup()

func _on_area_entered(area):
	item = area
	if item.selected:
		item_entered = true;
		var sig_name = area_entered.get_name()
		print("bg", sig_name, " ", area.items_sprite.frame)

func _on_area_exited(area):
	item_entered = false

func change_bg(fr):
	var new_bg = dict[bg_sprite.frame][fr]
	if new_bg > -1:
		bg_sprite.frame = new_bg
		f = new_bg
		await get_tree().create_timer(2).timeout


func do_popup():
	if f != 0:
		if !bg_dict[f][1]:
			bg_dict[f][1] = true
			Utils.popup(bg_dict[f][0])

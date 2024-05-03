extends Area2D

@onready var creation_animation = $AnimatedSprite2D
var item_entered = false
var item
var rgb_sel = 0
var rgb = [1, 0.5, 0.5]
var col_shift
var state = "start"
var oldMod
var is_mrr = false

var dict = {"start": {0: "blob", 1: "soul", 2: "plant", 3:"meat"}, "blob": {0: "shift", 1: "meat", 2: "plant", 3:"bldblob"},
			"soul": {0: "", 1: "you", 2: "whimsy", 3:"creature"}, "plant": {0: "", 1: "meat", 2: "shift", 3:""},
			"meat": {0: "", 1: "you", 2: "", 3:"burden"}, "burden": {0: "", 1: "you", 2: "", 3:"bldblob"},
			"you": {0: "", 1: "burden", 2: "soul", 3:"meat"}, "whimsy": {0: "", 1: "creature", 2: "", 3:"you"},
			"creature": {0: "", 1: "you", 2: "shift", 3:"meat"}, "bldblob": {0: "blob", 1: "burden", 2: "", 3:""}
	}
var crtn_dict = {"blob": false, "soul": false, "plant": false, "meat": false, "burden": false,
				"you": false, "whimsy": false, "creature": false, "bldblob": false}

# Called when the node enters the scene tree for the first time.
func _ready():
	creation_animation.play("start")
	oldMod = creation_animation.modulate
	col_shift = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if item_entered && !item.selected:
			print("dropped")
			change(item.f)
			item_entered =  false
	if col_shift:
		color_shift()
	if state == "you" && !is_mrr:
		creation_animation.play("burden")
		state = "burden"
		await get_tree().create_timer(2).timeout
	do_popup()


func _on_area_entered(area):
	item_entered = true;
	item = area
	item.iscreation =  true
	var sig_name = area_entered.get_name()
	print(sig_name, " ", area.items_sprite.frame)

func _on_area_exited(area):
	item_entered = false
	item.iscreation = false
	
func change(it_fr):
	var new_state = dict[state][it_fr]
	if !new_state.is_empty():
		col_shift = false
		match new_state:
			"shift":
				col_shift = true
			"you":
				if is_mrr:
					creation_animation.modulate = oldMod
					creation_animation.play(new_state)
					state = new_state
					await get_tree().create_timer(2).timeout
			_:
				creation_animation.modulate = oldMod
				creation_animation.play(new_state)
				state = new_state
				await get_tree().create_timer(2).timeout

func color_incr(x, y):
	rgb[x] += 0.001
	rgb[y] -= 0.001
	
func color_shift():
	match rgb_sel:
		0:
			if rgb[0] >= 1:
				rgb_sel = 1
			else:
				color_incr(0, 2)
		1: 
			if rgb[1] >= 1:
				rgb_sel = 2
			else:
				color_incr(1, 0)
		2: 
			if rgb[2] >= 1:
				rgb_sel = 0
			else:
				color_incr(2, 1)
	creation_animation.modulate = Color(rgb[0], rgb[1], rgb[2], 1)



func do_popup():
	if state != "start":
		if !crtn_dict[state]:
			crtn_dict[state] = true
			Utils.popup(state)

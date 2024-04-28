extends Node2D

var numHands = 4
const HEIGHT = 800
const LENGTH = 1200 
const hands = preload("res://UI/Hands/Hands.tscn")
const items = preload("res://Items/items.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
		drawHands()
		var itemtest = items.instantiate()
		itemtest.global_position = Vector2(1, 1)
		get_node("Items").add_child(itemtest)

func _input(event):
	if event.is_action("MouseClick"):
		print("MC: ", event.position)

func drawHands():
	var hand = hands.instantiate()
	var hand_width = hand.get_width()
	var space: float = (LENGTH - (hand_width*numHands))/(numHands+1)
	var x_pos = space
	print("space: ", space, " xpos: ", x_pos)
	for i in numHands:
		var hand1 = hands.instantiate()
		var item = items.instantiate()
		hand1.global_position = Vector2(x_pos, HEIGHT)
		print(hand1.get_handCntr())
		item.origin = Vector2(hand1.global_position.x + hand1.get_handCntr().x, hand1.global_position.y - hand1.get_handCntr().y)
		get_node("Hands").add_child(hand1)
		get_node("Items").add_child(item)
		x_pos += space + hand_width
		print("child ", i, " : ", hand1.global_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

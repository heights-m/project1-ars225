extends Node2D

var numHands = 4
const HEIGHT = 800
const LENGTH = 1200 
const hands = preload("res://UI/Hands/Hands.tscn")
const items = preload("res://Items/items.tscn")
const notif = preload("res://Notif.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
		drawHands()

func popup(text):
	if get_child_count() == 0:
		var notif1 = notif.instantiate()
		notif1.get_node("Label").text = "You have created " + str(text)
		add_child(notif1)
		await get_tree().create_timer(2).timeout
		notif.queue_free()
#func _input(event):
	#if event.is_action("MouseClick"):
		#print("MC: ", event.position)

func drawHands():
	var hand = hands.instantiate()
	var hand_width = hand.get_width()
	var space: float = (LENGTH - (hand_width*numHands))/(numHands+1)
	var x_pos = space
	print("space: ", space, " xpos: ", x_pos)
	for i in numHands:
		var hand1 = hands.instantiate()
		var item = items.instantiate()
		item.f = i
		hand1.global_position = Vector2(x_pos, HEIGHT)
		print(hand1.get_handCntr())
		item.origin = Vector2(hand1.global_position.x + hand1.get_handCntr().x, hand1.global_position.y - hand1.get_handCntr().y)
		get_node("Hands").add_child(hand1)
		get_node("Items").add_child(item)
		x_pos += space + hand_width
		print("child ", i, " : ", hand1.global_position)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("bg").f == 6 || get_node("bg").f == 7:
		get_node("creation").is_mrr = true
	else:
		get_node("creation").is_mrr = false

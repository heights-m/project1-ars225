extends Node

const notif = preload("res://Notif.tscn")

func popup(text):
	if get_child_count() == 0:
		var notif1 = notif.instantiate()
		notif1.get_node("Label").text = "You have created: " + str(text)
		add_child(notif1)
		await get_tree().create_timer(2).timeout
		self.remove_child(notif1)

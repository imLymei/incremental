class_name AppOpener
extends Button


const WINDOW_SCENE := preload("uid://fh603o2pbudl")


@export var app: App


func _on_pressed() -> void:
	var main_node := get_tree().get_first_node_in_group("Main")
	
	if not main_node:
		return
	
	if GameManager.open_windows.has(app.name):
		var old_window: WindowUi = GameManager.open_windows.get(app.name)
		old_window.move_to_front()
		return
	
	var window: WindowUi = WINDOW_SCENE.instantiate()
	window.app = app
	window.global_position = (Utils.window_size / 2) - (window.window_size / 2)
	main_node.add_child(window)

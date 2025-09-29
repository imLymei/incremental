@tool
class_name WindowUi
extends Control


const REDIMENSION_OFFSET: int = 0


@export var app: App
@export_group("Window Size")
@export var window_size := Vector2(500, 500)
@export var min_window_size := Vector2(500, 500)
@export var max_window_size := Vector2(500, 500)


@onready var title_bar_label: Label = %TitleBarLabel
@onready var app_body: Control = %AppBody


var _holding_offset: Vector2
var is_being_held := false
var is_redimensioning := false


func _enter_tree() -> void:
	if GameManager.open_windows.has(app.name):
		queue_free()
		return
	
	GameManager.open_windows.set(app.name, self)


func _ready() -> void:
	_update_window_size()
	title_bar_label.text = app.name
	var app_ui_scene: Control = app.ui_scene.instantiate()
	app_body.add_child(app_ui_scene)


func _process(_delta: float) -> void:
	size = window_size


func _update_window_size() -> void:
	window_size.x = clamp(window_size.x, min_window_size.x, max_window_size.x)
	window_size.y = clamp(window_size.y, min_window_size.y, max_window_size.y)


func _on_margin_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				move_to_front()
				_holding_offset = global_position - event.global_position
				
				is_being_held = true
			else:
				is_being_held = false
	elif is_being_held:
		if event is InputEventMouseMotion:
			global_position = event.global_position + _holding_offset


func _on_close_button_pressed() -> void:
	GameManager.open_windows.erase(app.name)
	queue_free()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			move_to_front()

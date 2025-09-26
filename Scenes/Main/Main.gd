extends Node2D


@onready var button: Button = $VBoxContainer/Button
@onready var label: Label = $VBoxContainer/Label


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	GameManager.souls_collected.connect(_on_souls_collected)


func _on_button_pressed() -> void:
	GameManager.collect_soul(100)


func _on_souls_collected(total_soul: int, collected_souls: int) -> void:
	print("NEW COLLECTED SOULS: %s" % [collected_souls])
	label.text = "SOULS: %s" % [total_soul]

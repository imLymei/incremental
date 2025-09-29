extends Node2D


const APPS_PATH := "res://Resources/Apps/"
const APP_OPENER = preload("uid://fxrimv77fm43")


@onready var apps_container: VBoxContainer = $AppsContainer


func _ready() -> void:
	Utils.for_each_resource_at(
		APPS_PATH,
		"App",
		_on_each_resource,
		true
	)


func _on_each_resource(app: Resource) -> void:
	if app is not App:
		return
	
	app = app as App
	
	var app_opener: AppOpener = APP_OPENER.instantiate()
	app_opener.app = app
	app_opener.text = app.name
	
	apps_container.add_child(app_opener)

class_name SmartLabel
extends Label


var _default_text: String
var label_variables: Dictionary[String, Variant]


func _enter_tree() -> void:
	_default_text = text


func update_label_variables(key: String, value: Variant) -> void:
	label_variables.set(key, value)
	
	_replace_text_variables()


func _replace_text_variables() -> void:
	var new_text := _default_text
	
	for key in label_variables:
		var value = label_variables[key]
		new_text = new_text.replace("{%s}" % [key], "%s" % [value])
	
	text = new_text

extends Node


var window_size: Vector2 :
	get():
		return get_viewport().get_visible_rect().size


func for_each_resource_at(dir_path: String, resource_type: String, on_each_resource: Callable, read_inner_dirs := false) -> void:
	for file_name in DirAccess.get_files_at(dir_path):
		var file_path := dir_path + file_name
		
		if not ResourceLoader.exists(file_path, resource_type):
			continue
		
		var item := ResourceLoader.load(file_path)
		
		on_each_resource.call(item)
	
	if read_inner_dirs:
		for dir_name in DirAccess.get_directories_at(dir_path):
			var current_dir_path := dir_path + dir_name + "/"
			for_each_resource_at(current_dir_path, resource_type, on_each_resource, read_inner_dirs)


func round_to_decimal(number: float, digit: int):
	return round(number * pow(10.0, digit)) / pow(10.0, digit)

extends Control


@onready var total_souls_label: SmartLabel = %TotalSoulsLabel
@onready var souls_bucket_label: SmartLabel = %SoulsBucketLabel


var display_souls_tween: Tween :
	set(new_value):
		if display_souls_tween:
			display_souls_tween.kill()
		
		display_souls_tween = new_value
var display_souls: int = GameManager.game_state.souls


func _ready() -> void:
	GameManager.souls_collected.connect(_on_souls_collected)
	total_souls_label.update_label_variables("TOTAL_SOULS", "%.f" % [GameManager.game_state.souls])
	souls_bucket_label.update_label_variables("SOULS_BUCKET", GameManager.game_state.souls_floating_bucket)


func _process(_delta: float) -> void:
	print("DISPLAYING SOULS")
	total_souls_label.update_label_variables("TOTAL_SOULS", display_souls)
	
	if display_souls == GameManager.game_state.souls:
		set_process(false)


func _on_souls_collected(_total_souls: int, souls_collected: int) -> void:
	total_souls_label.update_label_variables("REAL_SOULS", GameManager.game_state.souls)
	
	if souls_collected < 3:
		display_souls = GameManager.game_state.souls
		total_souls_label.update_label_variables("TOTAL_SOULS", GameManager.game_state.souls)
	else:
		display_souls_tween = create_tween()
		display_souls_tween.tween_property(self, "display_souls", GameManager.game_state.souls, GameManager.GAME_TICK_TIME)
		set_process(true)
	
	souls_bucket_label.update_label_variables("SOULS_BUCKET", GameManager.game_state.souls_floating_bucket)
	


func _on_harvet_soul_button_pressed() -> void:
	GameManager.collect_soul(1)

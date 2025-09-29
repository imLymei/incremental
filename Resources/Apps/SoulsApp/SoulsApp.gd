extends Control


@onready var total_souls_label: SmartLabel = %TotalSoulsLabel
@onready var souls_bucket_label: SmartLabel = %SoulsBucketLabel


func _ready() -> void:
	GameManager.souls_collected.connect(_on_souls_collected)
	total_souls_label.update_label_variables("TOTAL_SOULS", "%.f" % [GameManager.game_state.souls])
	souls_bucket_label.update_label_variables("SOULS_BUCKET", GameManager.game_state.souls_floating_bucket)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_souls_collected(_total_souls: int, _souls_collected: int) -> void:
	total_souls_label.update_label_variables("TOTAL_SOULS", GameManager.game_state.souls)
	souls_bucket_label.update_label_variables("SOULS_BUCKET", GameManager.game_state.souls_floating_bucket)


func _on_harvet_soul_button_pressed() -> void:
	GameManager.collect_soul(1)

extends Node


const ITEMS_PATH := "res://Resources/Items/"

const BUCKET_POP_TICK_TIME: float = 0.5
const GAME_TICK_TIME: float = 0.2


signal souls_collected(total_souls: int, collected_souls: int)
signal items_bought(item_id: int, total_items: int, amount_bought: int)

signal game_tick
signal bucket_tick


var open_windows: Dictionary[String, WindowUi]
var items: Dictionary[int, Item]

var game_timer: Timer
var bucket_timer: Timer

var game_state: GameState

var souls_per_seconds: float :
	get():
		var total: float = 0
		
		for item_id in game_state.items:
			var item: Item = items.get(item_id)
			total += 0.0 if item == null else (item.souls_per_second * game_state.items[item_id])
		
		return total
var max_souls_per_seconds: int :
	get():
		var total = 0
		return total


func _enter_tree() -> void:
	for file_name in DirAccess.get_files_at(ITEMS_PATH):
		var file_path = ITEMS_PATH + file_name
		
		if not ResourceLoader.exists(file_path, "Item"):
			continue
		
		var item: Item = ResourceLoader.load(file_path)
		items.set(item.id, item)


func _ready() -> void:
	game_state = GameState.new()
	
	bucket_timer = Timer.new()
	bucket_timer.one_shot = false
	bucket_timer.autostart = true
	bucket_timer.wait_time = BUCKET_POP_TICK_TIME
	add_child(bucket_timer)
	
	game_timer = Timer.new()
	game_timer.one_shot = false
	game_timer.autostart = true
	game_timer.wait_time = GAME_TICK_TIME
	add_child(game_timer)
	
	game_timer.timeout.connect(_on_game_tick)
	bucket_timer.timeout.connect(_on_bucket_tick)


func collect_soul(amount: float) -> void:
	var remainder := fmod(amount, 1)
	game_state.souls_floating_bucket += remainder
	
	if game_state.souls_floating_bucket >= 1:
		amount += floor(game_state.souls_floating_bucket)
		game_state.souls_floating_bucket = Utils.round_to_decimal(fmod(game_state.souls_floating_bucket, 1), 10)
	
	game_state.souls += floor(amount)
	souls_collected.emit(game_state.souls, amount)


func buy_item(item_id: int, amount: int) -> void:
	var total_items: int = game_state.items.get_or_add(item_id, 0) + amount
	game_state.items.set(item_id, total_items)
	items_bought.emit(item_id, total_items, amount)


func _on_game_tick() -> void:
	collect_soul(souls_per_seconds * GAME_TICK_TIME)
	game_tick.emit()


func _on_bucket_tick() -> void:
	bucket_tick.emit()

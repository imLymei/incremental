extends Node


const BUCKET_POP_TIME: float = 0.5


signal souls_collected(total_souls: int, collected_souls: int)


var bucket_timer: Timer
var game_state: GameState


func _ready() -> void:
	game_state = GameState.new()
	
	bucket_timer = Timer.new()
	bucket_timer.one_shot = false
	bucket_timer.autostart = true
	bucket_timer.wait_time = BUCKET_POP_TIME


func collect_soul(amount: int) -> void:
	game_state.souls += amount
	souls_collected.emit(game_state.souls, amount)

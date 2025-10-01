class_name ItemDisplayer
extends HBoxContainer

@export var enabled := true
@export var item: Item :
	set(new_value):
		item = new_value
		if not is_node_ready():
			return
		
		_update_item_labels()


@onready var item_name_label: Label = %ItemNameLabel
@onready var item_description_label: Label = %ItemDescriptionLabel
@onready var item_amount_label: Label = %ItemAmountLabel


func _ready() -> void:
	GameManager.items_bought.connect(
		func(item_id: int, _total_amount: int, _bought_amount: int):
			if item_id != item.id:
				return
			
			item_amount_label.text = str(GameManager.game_state.items.get(item.id, 0))
	)
	_update_item_labels()


func _update_item_labels() -> void:
	if not item:
		return
	
	item_name_label.text = item.name
	item_description_label.text = item.description
	item_amount_label.text = str(GameManager.game_state.items.get(item.id, 0))


func _on_item_buy_button_pressed() -> void:
	GameManager.buy_item(item.id, 1)

extends ScrollContainer


const ITEM_DISPLAYER = preload("uid://tisxpr14vhf8")


@onready var items_containers: VBoxContainer = %ItemsContainers


func _ready() -> void:
	for item_id in GameManager.items:
		var item: Item = GameManager.items.get(item_id)
		if not item:
			continue
		
		#var button := Button.new()
		#button.name = item.name
		#button.text = "%s: %s" % [item.name, GameManager.game_state.items.get(item_id, 0)]
		#button.pressed.connect(func():
			#GameManager.buy_item(item_id, 1)
		#)
		#button.mouse_filter = Control.MOUSE_FILTER_PASS
		#items_containers.add_child(button)
		
		var item_displayer: ItemDisplayer = ITEM_DISPLAYER.instantiate()
		item_displayer.item = item
		items_containers.add_child(item_displayer)
	
	#GameManager.items_bought.connect(_on_item_bought)


func _on_item_bought(item_id: int, total_items: int, _amount_bought: int) -> void:
	var item: Item = GameManager.items.get(item_id)
	if not item:
		return
	
	var button = items_containers.get_node(item.name)
	if not button:
		return
	
	button.text = "%s: %s" % [item.name, total_items]
	

extends Node
class_name OnGameStateDisable 


@export var do_disable: bool = true
## Auto - is currently not implemented yet
@export_enum("Local", "Multiplayer") var on_game_state: String = "Local"
@export_enum("None", "Local", "Multiplayer") var force_state: String = "None"

func _ready() -> void: 
	var parent: CanvasItem = get_parent()
	#printerr(GameManager.get_node("%NetworkState"))
	#if GameManager.get_node("%NetworkState")._active_state.name == on_game_state.to_pascal_case(): 
		#parent.visible = do_disable
	if force_state == on_game_state: 
		parent.visible = do_disable 
		

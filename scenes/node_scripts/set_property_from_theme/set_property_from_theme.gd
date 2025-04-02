@tool
extends Node
class_name SetPropertyFromTheme


@export var get_prop: String
@export var set_prop: String
@export_tool_button("Apply")
var apply = do_apply

func do_apply() -> void: 
	if !Engine.is_editor_hint(): 
		return
	var prop = ThemeManager.get(get_prop)
	get_parent().set(set_prop, prop)


func asd() -> int: 
	return await 1
	
	
func _ready() -> void: 
	var gay = await asd()
	#await asd()
	#await asd()
	#Thread.new()
	

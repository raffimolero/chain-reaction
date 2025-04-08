@tool
extends Node
class_name ParentInvisibleWhen

@export var when_editor: bool
@export var when_running: bool

@export var visible: bool
@export var disabled: bool
@export_tool_button("Update") var update_button = update


func _ready() -> void: 
	update()


func update() -> void: 
	if disabled: 
		return
	var parent: CanvasItem = get_parent()
	if when_editor && Engine.is_editor_hint(): 
		parent.visible = visible
	elif when_running && !Engine.is_editor_hint(): 
		parent.visible = visible

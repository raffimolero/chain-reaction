extends Node

const COLOR_EDITOR_RED = Color("ff7085")
const COLOR_EDITOR_YELLOW = Color("fbe99f")
const COLOR_EDITOR_GREEN = Color("42ffc2")
const COLOR_ICON_BLUE = Color("6393ff")

## This is mainly use so that i can scale it with the AnimationPlayer speed
## Also called as the default speed for all characters
## 5 (entity scaled_move_speed) / SCALED_BASE_SPEED

var viewport_size: Vector2: 
	get: 
		return get_viewport().get_visible_rect().size
		
var initial_viewport_size: Vector2 = Vector2(ProjectSettings.get_setting_with_override("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))



func get_enum_name(en, value) -> String: 
	return en.keys()[value]
	
	

extends OnPressedParent
class_name OnPressedOpenGameplayMenu

@export var menu: Control
@export var menu_position: Control
@export var default_position: Control
@export var open: bool
@export var animation: TweenArguments

func _pressed() -> void: 
	if open: 
		animation.create_tween_property(get_tree(), menu, "global_position", default_position.global_position).play()
		return
	animation.create_tween_property(get_tree(), menu, "global_position", menu_position.global_position).play()
	GameManager.pause(open)
	
	

extends Resource
class_name TweenArguments

@export var transition_type: Tween.TransitionType = Tween.TRANS_QUAD
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var duration: float = 0.4
@export var procces_mode: Tween.TweenProcessMode = Tween.TweenProcessMode.TWEEN_PROCESS_IDLE
@export var pause_mode: Tween.TweenPauseMode = Tween.TweenPauseMode.TWEEN_PAUSE_PROCESS

func set_ease_type(value: Tween.EaseType) -> TweenArguments: 
	ease_type = value
	return self


func set_duration(value: float) -> TweenArguments: 
	duration = value
	return self
	
	
func set_transition_type(value: Tween.TransitionType) -> TweenArguments: 
	transition_type = value
	return self


func create_tween(tree: SceneTree) -> Tween: 
	var tween: Tween = tree.create_tween().set_ease(ease_type).set_trans(transition_type).set_process_mode(procces_mode).set_pause_mode(pause_mode)
	return tween


func create_tween_property(tree: SceneTree, node: Node, property: NodePath, final_value) -> Tween: 
	var tween: Tween = create_tween(tree)
	tween.tween_property(node, property, final_value, duration)
	return tween

extends Node
class_name OnPressedParent

var disabled: bool

func _ready() -> void: 
	var parent := get_parent() 
	if parent is BaseButton: 
		parent.pressed.connect(_on_pressed)


func _on_pressed() -> void: 
	if disabled: 
		return
	_pressed()

# To be overriden
func _pressed() -> void: 
	pass
	
	

extends Resource
class_name ChatMessage

@export var id: String
@export var text: String
@export_file(".png", ".svg") var avatar_path: String
## If the message is from the sender
@export var is_sender: bool


func _init(_text: String, _avatar_path: String, _is_sender: bool = false) -> void: 
	text = _text
	avatar_path = _avatar_path
	is_sender = _is_sender
	

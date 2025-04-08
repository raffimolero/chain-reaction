extends OnPressedParent
class_name OnPressedSendMessage

@export var chat_log: ChatLog
@export var chat_input: TextEdit

## IDK just add functions here
func _pressed() -> void: 
	chat_log.add_message(
		ChatMessage.new(
			chat_input.text, 
			"", 
			true
		)
	)
	
	

@tool
extends VBoxContainer
class_name ChatMessageNode


@export var message: ChatMessage
@export_tool_button("Update") var update_button = update


func update() -> void: 
	update_is_sender()
	update_text()
	update_icon()


func update_is_sender() -> void: 
	var avatar = get_node("%Avatar")
	if message.is_sender: 
		alignment = BoxContainer.ALIGNMENT_END
		move_child(avatar, 1)
		return
	alignment = BoxContainer.ALIGNMENT_BEGIN
	move_child(avatar, 0)


func update_text() -> void: 
	%Message.text = message.text
	
	
func update_icon() -> void: 
	%Avatar.texture = load(message.avatar_path)
	
	

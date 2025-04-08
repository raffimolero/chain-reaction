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
	var avatar = %AvatarContainer
	if message.is_sender: 
		%Container.alignment = BoxContainer.ALIGNMENT_END
		%Container.move_child(avatar, 1)
		%PlayerName.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		return
	%Container.alignment = BoxContainer.ALIGNMENT_BEGIN
	%Container.move_child(avatar, 0)
	%PlayerName.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT


func update_text() -> void: 
	%Message.text = message.text
	
	
func update_icon() -> void: 
	if message.avatar_path.is_empty(): 
		return
	%Avatar.texture = load(message.avatar_path)
	
	

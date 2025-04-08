extends ScrollContainer
class_name ChatLog


@export var chat_message_scene: PackedScene


func add_messages(msgs: Array[ChatMessage]) -> void: 
	clear_messages()
	for msg: ChatMessage in msgs: 
		add_message(msg)


func add_message(msg: ChatMessage) -> void: 
	var node: ChatMessageNode = chat_message_scene.instantiate()
	%Container.add_child(node)
	node.message = msg
	node.update()


func clear_messages() -> void: 
	for i in %Container.get_children(): 
		i.queue_free()

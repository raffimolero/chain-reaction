extends ScrollContainer
class_name ChatLog


@export var chat_message_scene: PackedScene


func add_messages(msgs: Array[ChatMessage]) -> void: 
	clear_children()
	for msg in msgs: 
		add_message(msg)
	

func add_message(msg: ChatMessage) -> void: 
	var node: ChatMessageNode = chat_message_scene.instantiate()
	%Container.add_child(node)
	node.message = msg


func clear_children() -> void: 
	for i in get_children(): 
		i.queue_free()

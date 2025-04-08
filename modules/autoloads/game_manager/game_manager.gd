extends Node


var paused: bool

func pause(value: bool) -> bool: 
	get_tree().paused = value
	return value
	
func toggle_pause() -> bool: 
	paused = pause(!get_tree().paused)
	return paused 
	

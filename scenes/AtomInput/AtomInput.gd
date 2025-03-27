class_name AtomInput
extends Node2D

@onready var grid: AtomMap = get_parent()
@onready var cursor: Sprite2D = $Cursor
@export var team: String = 'player'

func _input(event: InputEvent) -> void:
	var cell := grid.local_to_map(grid.get_local_mouse_position())
	cursor.global_position = grid.to_global(grid.map_to_local(cell))

	if event.is_action_pressed('tap'):
		grid.grid_click.emit(team, cell)


func _init() -> void:
	pass

const NEIGHBORS = [
	Vector2i.UP,
	Vector2i.DOWN,
	Vector2i.LEFT,
	Vector2i.RIGHT,
]

func simulate():
	while true:
		var explosive := []
		for cell in grid:
			if grid[cell] >= 4:
				explosive.push_back(cell)
		
		if explosive.is_empty():
			break

		# for cell in explosive:
		# 	for neighbor in NEIGHBORS:
		# 		put(cell + neighbor, grid[cell] - 3)
		# 	grid[cell] = 0
		# debug_print()

class_name AtomMap
extends TileMapLayer

signal grid_click(team: String, cell: Vector2i)
func _grid_click(team: String, cell: Vector2i) -> void:
	pass

func _init() -> void:
	grid_click.connect(_grid_click)


func transfer(from: Vector2i, to: Vector2i):
	pass


func simulate():
	for tile: Vector2i in get_used_cells():
		var data: Array[Node2D] = get_cell_tile_data(tile).get_custom_data(&'cells')
		print(data)

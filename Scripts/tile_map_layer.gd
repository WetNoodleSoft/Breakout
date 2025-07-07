extends TileMapLayer

signal brick_destroyed

func _ready() -> void:
	pass

func brick_impact(brick_rid) -> void:
	if self.has_body_rid(brick_rid):
		self.erase_cell(get_coords_for_body_rid(brick_rid))
		self.emit_signal("brick_destroyed")
pass

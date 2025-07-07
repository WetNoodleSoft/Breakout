extends CanvasLayer

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var score: int = 0

func _ready() -> void:
	tile_map_layer.brick_destroyed.connect(_on_brick_destroyed)


func _on_brick_destroyed() -> void:
	score += 1
	rich_text_label.text = var_to_str(score)

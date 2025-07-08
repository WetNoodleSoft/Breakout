extends CanvasLayer

signal game_over

@onready var ball: CharacterBody2D = $"../Ball"
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var score_label: RichTextLabel = $ScoreLabel
@onready var lives_label: RichTextLabel = $LivesLabel
@onready var start_label: RichTextLabel = $StartLabel
@onready var score: int = 0
@onready var lives: int = 3

func _ready() -> void:
	tile_map_layer.brick_destroyed.connect(_on_brick_destroyed)
	ball.respawn.connect(_on_respawn)
	ball.start.connect(_on_start)


func _process(_delta) -> void:
	score_label.text = "SCORE: " + str(score)
	lives_label.text = "LIVES: " + str(lives)
	
func _on_brick_destroyed() -> void:
	score += 1


func _on_respawn() -> void:
	lives -= 1
	if lives < 1:
		_game_end()
		pass
	start_label.visible = true


func _on_start() -> void:
	start_label.visible = false


func _game_end() -> void:
	self.emit_signal("game_over")
	ScoreTracker.new_score(score)
	get_tree().reload_current_scene()

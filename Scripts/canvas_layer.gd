extends CanvasLayer

signal game_over

@onready var ball: CharacterBody2D = $"../Ball"
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var start_countdown: RichTextLabel = $StartCountdown
@onready var score_label: RichTextLabel = $ScoreLabel
@onready var lives_label: RichTextLabel = $LivesLabel
@onready var start_label: RichTextLabel = $StartLabel
@onready var hs_list_label: RichTextLabel = $PanelContainer/VSplitContainer/MarginContainer2/HSListLabel
@onready var high_scores_label: RichTextLabel = $PanelContainer/VSplitContainer/MarginContainer/HighScoresLabel
@onready var hs_panel: PanelContainer = $PanelContainer
@onready var score: int = 0
@onready var lives: int = 3
@onready var high_scores: Array = []
@onready var score_list: String
@onready var timer: Timer = $Timer


func _ready() -> void:
	tile_map_layer.brick_destroyed.connect(_on_brick_destroyed)
	ball.respawn.connect(_on_respawn)
	ball.start.connect(_on_start)
	start_countdown.visible = false
	high_scores = ScoreTracker.get_scores()
	print(high_scores)
	for entry in high_scores:
		if entry > 0:
			score_list += str(entry)+"\n"
	hs_list_label.text = score_list
	hs_panel.visible = true
	ball.visible = false


func _process(_delta) -> void:
	score_label.text = ("SCORE: " + str(score))


func start_timer() -> void:
	start_countdown.visible = true
	var time_remaining: int = 3
	while time_remaining > 0:
		print(time_remaining)
		start_countdown.text = str(time_remaining)
		timer.start(0.7)
		await timer.timeout
		time_remaining -= 1
	start_countdown.visible = false


func _on_brick_destroyed() -> void:
	score += 1


func _on_respawn() -> void:
	lives -= 1
	lives_label.text = "LIVES: " + str(lives)
	if lives < 1:
		_game_end()
		pass
	start_label.visible = true


func _on_start() -> void:
	start_label.visible = false
	hs_panel.visible = false
	ball.visible = true	


func _game_end() -> void:
	self.emit_signal("game_over")
	ScoreTracker.record_score(score)
	get_tree().call_deferred("reload_current_scene")

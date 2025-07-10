extends Node2D

var high_scores: Array = []

func record_score(score: int) -> void:
	high_scores.append(score)
	high_scores.sort()
	high_scores.reverse()
	if high_scores.size() > 5:
		high_scores.resize(high_scores.size() - 1)


func get_scores() -> Array:
	return high_scores

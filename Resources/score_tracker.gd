extends Node2D

var high_score: Array = []
var new_score: Dictionary = {}

func record_score(name: String, score: int) -> void:
	print(high_score)
	new_score.clear()
	new_score[name] = score
	if high_score.size() > 4:
		high_score.append(new_score)
		high_score.sort()
		high_score.resize(high_score.size() - 1)
		pass
	high_score.append(new_score)

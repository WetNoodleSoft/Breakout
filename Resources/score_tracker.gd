extends Resource

var high_score: Array = []


func new_score(name: String, score: int) -> void:
	if high_score.size() > 4:
		high_score.append({name = score})
		var lowest_score = high_score[0]
		var i = 0
		for record in high_score:
			if record < lowest_score:
				lowest_score = record
			
	high_score.append({name = score})
		pass
	
	pass

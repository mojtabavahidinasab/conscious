extends HBoxContainer


func _ready():
	theme = بازی.سبک


func بایست(چیزها: Array):
	$آوا.سردادن("دکمه")
	for چیز in چیزها:
		if چیز.name == "ایستاده":
			چیز.show()
		elif چیز.has_method("hide"):
			چیز.hide()
	get_tree().paused = true

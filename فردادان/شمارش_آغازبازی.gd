extends Label
class_name آغازبازی
static var بازی‌ساز: bool = false


func آغازبازی():
	$"آوا".سردادن("آغازبازی")
	hide()
	get_tree().paused = false


func _ready():
	theme = بازی.سبک_برگزیده
	get_tree().paused = true
	if بازی‌ساز:
		آغازبازی()
	else:
		$آوا.سردادن("آغازشمارشگر")
		$"شمارشگرآغاز".start()


func _process(delta: float):
	text = پارسی‌سازی.شماره_پارسی(str(int($"شمارشگرآغاز".time_left)))

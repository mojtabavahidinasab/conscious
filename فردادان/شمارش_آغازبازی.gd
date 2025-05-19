extends Label
class_name آغازبازی
static var بازی‌ساز: bool = false


func آغازبازی():
	$"آوا".سردادن("آغازبازی")
	hide()
	get_tree().paused = false


func _ready():
	get_tree().paused = true
	if بازی‌ساز:
		آغازبازی()
	else:
		$آوا.سردادن("آغازشمارشگر")
		$"شمارشگرآغاز".start()


func _process(delta: float):
	text = پارسی‌سازی.شماره_پارسی(int($"شمارشگرآغاز".time_left))

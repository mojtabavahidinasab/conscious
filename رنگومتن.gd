extends Control
var امتیاز = 0

func پیشروی(متغیر) -> void:
	var رنگ‌ها = {
		"آبی": Color.BLUE,
		"مشکی": Color.BLACK,
		"سفید": Color.WHITE,
		"زرد": Color.YELLOW,
		"سبز": Color.GREEN,
		"قرمز": Color.RED
		}
	if متغیر is bool:
		if رنگ‌ها[$تن/متن.text] == $تن/رنگ.modulate:
			if متغیر:
				امتیاز += 1
				$سر/امتیاز.text = str(امتیاز)
		else:
			if not متغیر:
				امتیاز += 1
				$سر/امتیاز.text = str(امتیاز)
	$تن/متن.modulate = رنگ‌ها.values().pick_random()
	$تن/رنگ.modulate = رنگ‌ها.values().pick_random()
	$تن/متن.text = رنگ‌ها.keys().pick_random()
	$تن/رنگ.text = رنگ‌ها.keys().pick_random()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	پیشروی("آغاز")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $شمارشگرآغاز.time_left:
		$شمارش.text = str(int($شمارشگرآغاز.time_left))
	$سر/زمان.text = str(int($شمارشگر.time_left))


func _بله() -> void:
	پیشروی(true)


func _خیر() -> void:
	پیشروی(false)


func _بایست() -> void:
	if $شمارشگر.paused:
		$سر/ایستاننده.text = "  | |  "
	else:
		$سر/ایستاننده.text = "  <  "
	$شمارشگر.paused = not $شمارشگر.paused
	$پا.visible = not $پا.visible
	$ایستاده.visible = not $ایستاده.visible
	$ایستاده/امتیاز.text = str(امتیاز)
	$تن.visible = not $تن.visible


func _آغازبازی() -> void:
	$شمارش.hide()
	$پا/بله.disabled = false
	$پا/خیر.disabled = false
	$سر/ایستاننده.disabled = false
	$تن.show()
	$شمارشگر.start()


func _پایان_بازی() -> void:
	$ایستاده.show()
	$سر.hide()
	$پا.hide()
	$تن.hide()
	$ایستاده/امتیاز.text = str(امتیاز)


func _برگرد() -> void:
	get_tree().change_scene_to_file("res://سرآغاز.tscn")

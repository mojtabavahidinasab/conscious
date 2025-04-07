extends Control
var امتیاز = 0


func پیشروی(متغیر) -> void:
	var واکه‌ها = [
	"A", "E", "I", 
	"O", "U" 
	]
	var همخوان‌ها = [
	"B", "C", "D",
	"F", "G", "H",
	"J", "K", "L",
	"M", "N", "P",
	"Q", "R", "S",
	"T", "V", "W",
	"X", "Y", "Z"
	]
	var زوج‌ها = [0, 2, 4, 6, 8]
	var فردها = [1, 3, 5, 7, 9]
	if متغیر is bool:
		if $تن/زوج.modulate == Color.CYAN:
			if متغیر:
				for زوج in زوج‌ها:
					if str(زوج) in $تن/زوج.text:
						امتیاز += 1
						$سر/امتیاز.text = str(امتیاز)
			else:
				for فرد in فردها:
					if str(فرد) in $تن/زوج.text:
						امتیاز += 1
						$سر/امتیاز.text = str(امتیاز)
		else:
			if متغیر:
				for واکه in واکه‌ها:
					if واکه in $تن/واکه.text:
						امتیاز += 1
						$سر/امتیاز.text = str(امتیاز)
			else:
				for همخوان in همخوان‌ها:
					if همخوان in $تن/واکه.text:
						امتیاز += 1
						$سر/امتیاز.text = str(امتیاز)
	
	var متن‌ها = [$تن/زوج, $تن/واکه]
	if randi_range(0, 1):
		متن‌ها[0].modulate = Color.WHITE
		متن‌ها[1].modulate = Color.CYAN
	else:
		متن‌ها[0].modulate = Color.CYAN
		متن‌ها[1].modulate = Color.WHITE
	for متن in متن‌ها:
		if randi_range(0, 1):
			if randi_range(0, 1):
				متن.text = str(زوج‌ها.pick_random())
			else:
				متن.text = str(فردها.pick_random())
			if randi_range(0, 1):
				متن.text += همخوان‌ها.pick_random()
			else:
				متن.text += واکه‌ها.pick_random()
		else:
			if randi_range(0, 1):
				متن.text = همخوان‌ها.pick_random()
			else:
				متن.text = واکه‌ها.pick_random()
			if randi_range(0, 1):
				متن.text += str(زوج‌ها.pick_random())
			else:
				متن.text += str(فردها.pick_random())


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

extends Control
## نام این بازی در Lumosity برابر Color Match است
##
## اگر نام شایسته‌تری دارید، خواهشمندم پیشنهاد دهید
## نشانی برای پیشنهاد نام شایسته TODO
##
## @tutorial:             https://github.com/mojtabavahidinasab/conscious/TODO

var امتیاز = 0

## برابر پارسی «audio» آویس می‌باشد. هنگام فشردن دکمه‌های برگشت و ایستادن، آویسی شانسی پخش خواهد شد.
var آویس‌های_دکمه = []


## همان پیشرفت. چه بازیکن درست باشد و چه نادرست پیشرفت برداشت می‌شود.
## بررسی درستی یا نادرستی بازیکن و دگرگونی متن برچسب‌ها کار ایشان می‌باشد.
func پیشروی(متغیر = null):
	var رنگ‌ها = {
		"آبی": Color.BLUE,
		"مشکی": Color.BLACK,
		"سفید": Color.WHITE,
		"زرد": Color.YELLOW,
		"سبز": Color.GREEN,
		"قرمز": Color.RED
		}
	if متغیر != null:
		if رنگ‌ها[$تن/متن.text] == $تن/رنگ.get("theme_override_colors/font_color"):
			if متغیر:
				آویس("درست")
				امتیاز += 1
				$سر/امتیاز.text = str(امتیاز)
			else:
				آویس("نادرست")
		else:
			if not متغیر:
				آویس("درست")
				امتیاز += 1
				$سر/امتیاز.text = str(امتیاز)
			else:
				آویس("نادرست")
	$تن/متن.set("theme_override_colors/font_color", رنگ‌ها.values().pick_random())
	$تن/رنگ.set("theme_override_colors/font_color", رنگ‌ها.values().pick_random())
	$تن/متن.text = رنگ‌ها.keys().pick_random()
	$تن/رنگ.text = رنگ‌ها.keys().pick_random()


## در آغازبازی یکبار متن‌های برچسب‌ها را دگرگون ساز.
## تا با هر بازآغاز همان متن‌های بازی پیش بازگو نگردند.
## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _ready() -> void:
	پیشروی()
	
	# اینها را نمی‌شد خارج از تابع نوشت. زیرا خطای زیر از این کار ایراد می‌گیرد:
	# Line X:Unexpected identifier "آویس‌های_دکمه" in class body.
	آویس‌های_دکمه.append(preload("res://جلوه آویسی/دکمه/بشکن۱.wav"))
	آویس‌های_دکمه.append(preload("res://جلوه آویسی/دکمه/بشکن۲.wav"))


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _process(delta: float):
	if $شمارشگرآغاز.time_left:
		$شمارش.text = str(int($شمارشگرآغاز.time_left))
	$سر/زمان.text = str(int($شمارشگر.time_left))


func بایست():
	آویس("دکمه")
	if $شمارشگر.paused:
		$سر/ایستاننده.text = "  | |  "
	else:
		$سر/ایستاننده.text = "  <  "
	$شمارشگر.paused = not $شمارشگر.paused
	$پا.visible = not $پا.visible
	$ایستاده.visible = not $ایستاده.visible
	$ایستاده/امتیاز.text = str(امتیاز)
	$تن.visible = not $تن.visible


## هنگام پایان شمارشگر آغاز تابع فراخوانی می‌گردد
func آغازبازی():
	$شمارش.hide()
	آویس("آغاز")
	$پا/بله.disabled = false
	$پا/خیر.disabled = false
	$سر/ایستاننده.disabled = false
	$تن.show()
	$شمارشگر.start()


## هنگام لبریز شدن جام عمر بازی فراخوانی می‌شود
func پایان_بازی():
	$ایستاده.show()
	$سر.hide()
	$پا.hide()
	$تن.hide()
	$ایستاده/امتیاز.text = str(امتیاز)


func آویس(متغیر):
	if متغیر == "درست":
		$آویس.stream = preload("res://جلوه آویسی/درست.ogg")
		$آویس.play()
	elif متغیر == "نادرست":
		$آویس.stream = preload("res://جلوه آویسی/نادرست.wav")
		$آویس.play()
	elif متغیر == "پیروزی":
		$آویس.stream = preload("res://جلوه آویسی/پیروزی۱.wav")
		$آویس.play()
	elif متغیر == "باخت":
		$آویس.stream = preload("res://جلوه آویسی/باخت.wav")
		$آویس.play()
	elif متغیر == "آغاز":
		$آویس.stream = preload("res://جلوه آویسی/آغاز.mp3")
		$آویس.play()
	elif متغیر == "دکمه":
		$آویس.stream = آویس‌های_دکمه.pick_random()
		$آویس.play()


func برگرد():
	آویس("دکمه")
	get_tree().change_scene_to_file("res://صحنه‌ها/سرآغاز.tscn")

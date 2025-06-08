extends Control
## نام این بازی در Lumosity برابر Color Match است
##
## اگر نام شایسته‌تری دارید، خواهشمندم پیشنهاد دهید
## نشانی برای پیشنهاد نام شایسته TODO
##
## @tutorial:             https://github.com/mojtabavahidinasab/conscious/TODO



## همان پیشرفت. چه بازیکن درست باشد و چه نادرست پیشرفت برداشت می‌شود.
## بررسی درستی یا نادرستی بازیکن و دگرگونی متن برچسب‌ها کار ایشان می‌باشد.
func پیشروی(متغیر = null):
	var رنگ‌ها = {
		"آبی": Color.BLUE,
		"مشکی": Color.BLACK,
		"زرد": Color.YELLOW,
		"قرمز": Color.RED
		}
	if متغیر != null:
		if رنگ‌ها[$تن/متن.text] == $تن/رنگ.get("theme_override_colors/font_color"):
			if متغیر:
				$آوا.سردادن("درست")
				بازی.امتیاز += 1
			else:
				$آوا.سردادن("نادرست")
		else:
			if not متغیر:
				$آوا.سردادن("درست")
				بازی.امتیاز += 1
			else:
				$آوا.سردادن("نادرست")
	$تن/متن.set("theme_override_colors/font_color", رنگ‌ها.values().pick_random())
	$تن/رنگ.set("theme_override_colors/font_color", رنگ‌ها.values().pick_random())
	$تن/متن.text = رنگ‌ها.keys().pick_random()
	$تن/رنگ.text = رنگ‌ها.keys().pick_random()


## در آغازبازی یکبار متن‌های برچسب‌ها را دگرگون ساز.
## تا با هر بازآغاز همان متن‌های بازی پیش بازگو نگردند.
## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _ready() -> void:
	بازی.امتیاز = 0
	theme = بازی.سبک_برگزیده
	$"شمارشگر".start()
	await $"شمارش".آغاز
	پیشروی()


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _process(delta: float):
	$سر/زمان.text = "زمان: {0}".format([پارسی‌سازی.شماره_پارسی(str(int($"شمارشگر".time_left)))])


## هنگام لبریز شدن جام عمر بازی فراخوانی می‌شود
func پایان_بازی():
	$"ایستاده/ادامه".hide()
	$ایستاده.show()
	$سر.hide()
	$پا.hide()
	$تن.hide()
	get_tree().paused = true

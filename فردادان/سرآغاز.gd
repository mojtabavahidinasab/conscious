extends Control
## نخستین صفحه بازی.
##
## کار این فرداد آغاز بازی برگزیده بازیکن می‌باشد،
## کارهای پیکربندی و درباره‌ما هم می‌کند.
##
## @tutorial:             https://github.com/mojtabavahidinasab/conscious/TODO


# نمونه فرداد برای بومی‌سازی رابط کاربری بازی در فردایی TODO
#var زبان = "پارسی"
#if language == "خودکار":
	#var زبان_کاربر = OS.get_locale_language()
	#TranslationServer.set_locale(زبان_کاربر)
#else:
	#TranslationServer.set_locale(زبان)


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _ready():
	theme = بازی.سبک
	# راست‌چین کردن اجباری
	for بخش in $"بازی‌ها/بخش‌ها".get_children():
		for بازی in بخش.get_children():
			if بازی is ScrollContainer:
				بازی.scroll_horizontal = 99999


## این تابع آغازگر بازی برگزیده بازیکن است.
## فردا نمایش پیام‌های زیر را پیاده‌سازی می‌کنم
## پیام این بازی در دست توسعه است به همراه دعوت به همکاری TODO
## پیام راهنمای هر بازی به همراه دکمه آغاز TODO
## پیام‌های بخش پیکربندی و درباره ما و دیگر TODO
func آغازبازی(بازی = null):
	$آوا.سردادن("دکمه")
	if بازی:
		get_tree().change_scene_to_file(بازی)


func نمایش‌بخش(بخش: String):
	$آوا.سردادن("دکمه")
	for هربخش in get_children():
		if هربخش is ScrollContainer:
			if هربخش.name == بخش:
				هربخش.show()
			else:
				هربخش.hide()


func تغییرسبک(اندیس: int):
	$آوا.سردادن("آغازبازی")
	if اندیس == 0:
		RenderingServer.set_default_clear_color(Color.WHITE)
		بازی.سبک = preload("res://سبک‌ها/آفتاب.tres")  # آفتاب
		theme = بازی.سبک
	elif اندیس == 1:
		RenderingServer.set_default_clear_color(Color.BLACK)
		بازی.سبک = preload("res://سبک‌ها/مهتاب.tres")  # مهتاب
		theme = بازی.سبک

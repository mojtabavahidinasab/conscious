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
	var پرونده_پیکربندی: FileAccess = FileAccess.open("user://{0}".format([بازی.نام_پرونده_پیکربندی]), FileAccess.READ)
	if پرونده_پیکربندی:
		var پیکربندی = پرونده_پیکربندی.get_as_text(true).replace("\n", "").split(",")
		if پیکربندی.has("سبک"):
			if پیکربندی[پیکربندی.find("سبک") + 1] == "آفتاب":
				تغییرسبک(0)
			elif پیکربندی[پیکربندی.find("سبک") + 1] == "مهتاب":
				تغییرسبک(1)
				$"پیکربندی/بخش‌ها/سبک/گزینه‌ها".select(1)
	theme = بازی.سبک_برگزیده
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


func درباره_بازی(درباره: String):
	pass


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
	var پرونده_پیکربندی: FileAccess = FileAccess.open("user://{0}".format([بازی.نام_پرونده_پیکربندی]), FileAccess.READ_WRITE)
	var پیکربندی: PackedStringArray
	if پرونده_پیکربندی:
		پیکربندی = پرونده_پیکربندی.get_as_text(true).replace("\n", "").split(",")
	else:
		پرونده_پیکربندی = FileAccess.open("user://{0}".format([بازی.نام_پرونده_پیکربندی]), FileAccess.WRITE)
	if اندیس == 0:
		RenderingServer.set_default_clear_color(Color.WHITE)
		بازی.سبک_برگزیده = preload(بازی.سبک_آفتاب)  # آفتاب
		theme = بازی.سبک_برگزیده
		if پیکربندی.has("سبک"):
			پیکربندی[پیکربندی.find("سبک") + 1] = "آفتاب"
		else:
			پیکربندی.append("سبک")
			پیکربندی.append("آفتاب")
	elif اندیس == 1:
		RenderingServer.set_default_clear_color(Color.BLACK)
		بازی.سبک_برگزیده = preload(بازی.سبک_مهتاب)  # مهتاب
		theme = بازی.سبک_برگزیده
		if پیکربندی.has("سبک"):
			پیکربندی[پیکربندی.find("سبک") + 1] = "مهتاب"
		else:
			پیکربندی.append("سبک")
			پیکربندی.append("مهتاب")
	var موقت :String = ",".join(پیکربندی)
	پرونده_پیکربندی.store_string(موقت)

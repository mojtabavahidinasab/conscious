extends Control
## نام این بازی در Lumosity برابر Memory Matrix است
##
## اگر نام شایسته‌تری دارید، خواهشمندم پیشنهاد دهید
## نشانی برای پیشنهاد نام شایسته TODO
##
## @tutorial:             https://github.com/mojtabavahidinasab/conscious/TODO

var امتیاز = 0

## برابر پارسی «audio» آویس می‌باشد. هنگام فشردن دکمه‌های برگشت و ایستادن، آویسی شانسی پخش خواهد شد.
var آویس‌های_دکمه = []
var بعدها = 5
var شمار_گزینه‌ها = (بعدها ** 2)
var برگزیدگان = []
var شمار_برگزیدگان = int(شمار_گزینه‌ها / 2)
var بیشینه_شمار_برگزیدگان = int(شمار_گزینه‌ها / 1.5)
var کمینه_شمار_برگزیدگان = int(شمار_گزینه‌ها / 2.5)
var برگزیدگان_بازیکن = 0


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _ready():
	
	# اینها را نمی‌شد خارج از تابع نوشت. زیرا خطای زیر از این کار ایراد می‌گیرد:
	# Line X:Unexpected identifier "آویس‌های_دکمه" in class body.
	آویس‌های_دکمه.append(preload("res://جلوه آویسی/دکمه/بشکن۱.wav"))
	آویس‌های_دکمه.append(preload("res://جلوه آویسی/دکمه/بشکن۲.wav"))


func بایست():
	آویس("دکمه")
	$ایستاده.visible = not $ایستاده.visible
	if $ایستاده.visible:
		$سر/ایستاننده.text = "  | |  "
	else:
		$سر/ایستاننده.text = "  <  "
	$ایستاده/امتیاز.text = str(امتیاز)
	$تن.visible = not $تن.visible


## هنگام لبریز شدن جام عمر بازی فراخوانی می‌شود
func پایان_بازی():
	$ایستاده.show()
	$سر.hide()
	$تن.hide()
	$ایستاده/امتیاز.text = str(امتیاز)


## هنگام پایان شمارشگر آغاز تابع فراخوانی می‌گردد
func آغازبازی():
	آویس("آغاز")
	$شمارش.hide()
	$سر/ایستاننده.disabled = false
	$"تن".show()
	نمایش()


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _process(delta: float):
	if $شمارشگرآغاز.time_left:
		$شمارش.text = str(int($شمارشگرآغاز.time_left))


func برگرد():
	آویس("دکمه")
	get_tree().change_scene_to_file("res://صحنه‌ها/سرآغاز.tscn")


## اگر بازیکن خانه نادرستی گزیده باشد. این تابع فراحوانی و خانه‌های درست آشکار می‌گردند.
func نمایش_درست():
	for سطر in range(1, بعدها + 1):
		for ستون in range(1, بعدها + 1):
			get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
	for برگزیده in برگزیدگان:
		var سطر_برگزیده = برگزیده[0]
		var ستون_برگزیده = برگزیده[1]
		var نوسبک = get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).get_theme_stylebox("disabled").duplicate()
		get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).add_theme_stylebox_override("disabled", نوسبک)
		get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).get("theme_override_styles/disabled").bg_color = Color.CYAN
	$"شمارشگردرست".start()


func برگزیدن():
	for گزینش in range(شمار_برگزیدگان - len(برگزیدگان)):
		var سطر_برگزیده = randi_range(1, بعدها)
		var ستون_برگزیده = randi_range(1, بعدها)
		if [سطر_برگزیده, ستون_برگزیده] not in برگزیدگان:
			برگزیدگان.append([سطر_برگزیده, ستون_برگزیده])
	if len(برگزیدگان) != شمار_برگزیدگان:
		return برگزیدن()


## نخستین تابعی که در آغاز بازی فراخوانی می‌گردد.
## اگر همه خانه‌های برگزیده درست بازگزینش گردند تابع فراخوانی می‌گردد.
func نمایش():
	for سطر in range(1, بعدها + 1):
		for ستون in range(1, بعدها + 1):
			var نوسبک = get_node("تن/{0}/{1}".format([سطر, ستون])).get_theme_stylebox("disabled").duplicate()
			get_node("تن/{0}/{1}".format([سطر, ستون])).add_theme_stylebox_override("disabled", نوسبک)
			get_node("تن/{0}/{1}".format([سطر, ستون])).get("theme_override_styles/disabled").bg_color = Color.BLACK
			get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
			get_node("تن/{0}/{1}".format([سطر, ستون])).button_pressed = false
	
	برگزیدن()
	for برگزیده in برگزیدگان:
		var سطر_برگزیده = برگزیده[0]
		var ستون_برگزیده = برگزیده[1]
		
		var نوسبک = get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).get_theme_stylebox("disabled").duplicate()
		get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).add_theme_stylebox_override("disabled", نوسبک)
		get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).get("theme_override_styles/disabled").bg_color = Color.CYAN
	$"شمارشگر".start()


## پس از اینکه خانه‌های درست را به بازیکنی که خانه نادرستی گزیده بود نشان داده شد به بازی ادامه ده.
func پایان_نمایش_درست():
	برگزیدگان.clear()
	for سطر in range(1, بعدها + 1):
		for ستون in range(1, بعدها + 1):
			var نوسبک = get_node("تن/{0}/{1}".format([سطر, ستون])).get_theme_stylebox("disabled").duplicate()
			get_node("تن/{0}/{1}".format([سطر, ستون])).add_theme_stylebox_override("disabled", نوسبک)
			get_node("تن/{0}/{1}".format([سطر, ستون])).get("theme_override_styles/disabled").bg_color = Color.BLACK
			get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
			get_node("تن/{0}/{1}".format([سطر, ستون])).button_pressed = false
	
	if شمار_برگزیدگان == کمینه_شمار_برگزیدگان:
		var پاکسطر = get_node("تن/{0}".format([بعدها]))
		$"تن".remove_child(پاکسطر)
		بعدها -= 1
		for هرسطری in range(1, بعدها + 1):
			var پاکستون = get_node("تن/{0}/{1}".format([هرسطری, بعدها]))
			get_node("تن/{0}".format([هرسطری])).remove_child(پاکستون)
		بعدها -= 1
		شمار_گزینه‌ها = (بعدها ** 2)
		شمار_برگزیدگان = int(شمار_گزینه‌ها / 2)
		بیشینه_شمار_برگزیدگان = int(شمار_گزینه‌ها / 1.5)
		کمینه_شمار_برگزیدگان = int(شمار_گزینه‌ها / 2.5)
	
	نمایش()


## دگرسانی این تابع با «پایان_نمایش_درست» بازگو گردد TODO
func پایان_نمایش():
	for برگزیده in برگزیدگان:
		var سطر_برگزیده = برگزیده[0]
		var ستون_برگزیده = برگزیده[1]
		get_node("تن/{0}/{1}".format([سطر_برگزیده, ستون_برگزیده])).get("theme_override_styles/disabled").bg_color = Color.BLACK
	for سطر in range(1, بعدها + 1):
		for ستون in range(1, بعدها + 1):
			get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = false


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


## همان پیشرفت. چه بازیکن درست باشد و چه نادرست پیشرفت برداشت می‌شود.
## بررسی درستی بازگزینی خانه‌ها، کاهش و افزایش بعد تخته کار ایشان می‌باشد.
func پیشروی(متغیر):
	برگزیدگان_بازیکن += 1
	var سطر = متغیر[0]
	var ستون = متغیر[1]
	var نوسبک = get_node("تن/{0}/{1}".format([سطر, ستون])).get_theme_stylebox("disabled").duplicate()
	if متغیر in برگزیدگان:
		آویس("درست")
		get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
		get_node("تن/{0}/{1}".format([سطر, ستون])).add_theme_stylebox_override("disabled", نوسبک)
		get_node("تن/{0}/{1}".format([سطر, ستون])).get("theme_override_styles/disabled").bg_color = Color.CYAN
		برگزیدگان.erase(متغیر)
	else:
		آویس("نادرست")
		get_node("تن/{0}/{1}".format([سطر, ستون])).add_theme_stylebox_override("disabled", نوسبک)
		get_node("تن/{0}/{1}".format([سطر, ستون])).get("theme_override_styles/disabled").bg_color = Color.HOT_PINK
		get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
	if برگزیدگان_بازیکن == شمار_برگزیدگان:
		برگزیدگان_بازیکن = 0
		if not len(برگزیدگان):
			آویس("پیروزی")  #TODO: آویس را ببر تا کوتاه باشد
			شمار_برگزیدگان += 1
			if شمار_برگزیدگان == بیشینه_شمار_برگزیدگان:
				بعدها += 1
				شمار_گزینه‌ها = (بعدها ** 2)
				شمار_برگزیدگان = int(شمار_گزینه‌ها / 2)
				بیشینه_شمار_برگزیدگان = int(شمار_گزینه‌ها / 1.5)
				کمینه_شمار_برگزیدگان = int(شمار_گزینه‌ها / 2.5)
				var نوسطر = HBoxContainer.new()
				نوسطر.name = str(بعدها)
				$"تن".add_child(نوسطر)
				$"تن".get_child(بعدها - 1).size_flags_vertical = SIZE_EXPAND_FILL
				for هرسطر in range(1, بعدها + 1):
					for هرستون in range(1, بعدها + 1):
						var نوستون = BaseButton.new() # چرا نوخانه‌ها نامرئی‌اند؟ TODO
						نوستون.name = str(هرستون)
						if هرسطر == بعدها or هرستون == بعدها:
							get_node("تن/{0}".format([هرسطر])).add_child(نوستون)
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).size_flags_horizontal = SIZE_EXPAND_FILL
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).pressed.connect(پیشروی.bind([هرسطر, هرستون]))
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).theme = preload("res://تم.tres")
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).add_theme_stylebox_override("disabled", نوسبک)
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).toggle_mode = true
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).disabled = true
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).get("theme_override_styles/disabled").bg_color = Color.BLACK
			امتیاز += 1
			$"سر/امتیاز".text = str(امتیاز)
			نمایش()
		else:
			if $"آویس".stream == preload("res://جلوه آویسی/نادرست.wav"):
				آویس("باخت")
			if شمار_برگزیدگان > 4:
				شمار_برگزیدگان -= 1
			نمایش_درست()

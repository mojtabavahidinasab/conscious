extends Control
## نام این بازی در Lumosity برابر Memory Matrix است
##
## اگر نام شایسته‌تری دارید، خواهشمندم پیشنهاد دهید
## نشانی برای پیشنهاد نام شایسته TODO
##
## @tutorial:             https://github.com/mojtabavahidinasab/conscious/TODO

var امتیاز = 0
var تلاش‌ها = 5

var بعدها = 5
var شمار_خانه‌ها = (بعدها ** 2)
var برگزیدگان = []
var شمار_برگزیدگان = int(شمار_خانه‌ها / 2)
var بیشینه_شمار_برگزیدگان = int(شمار_خانه‌ها / 1.5)
var کمینه_شمار_برگزیدگان = int(شمار_خانه‌ها / 2.5)
var برگزیدگان_بازیکن = 0


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _ready():
	تلاش‌ها = 5
	$"سر/ایستاننده".pressed.connect($"سر".بایست.bind(get_children()))
	$"ایستاده/ادامه".pressed.connect($"ایستاده".ادامه_بازی.bind(get_children()))
	$"ایستاده/ازنو".pressed.connect($"ایستاده".بازی_ازنو)
	$"ایستاده/برگردان".pressed.connect($"ایستاده".بیرون_رفتن_ازبازی)
	for سطر in range(1, بعدها + 1):
		for ستون in range(1, بعدها + 1):
			get_node("تن/{0}/{1}".format([سطر, ستون])).pressed.connect(پیشروی.bind([سطر, ستون]))
	نمایش()


func چشمک():
	var تلاش = get_node("پا/{0}".format([تلاش‌ها]))
	if تلاش.get_theme_stylebox("panel").bg_color == Color.TRANSPARENT:
		تلاش.get_theme_stylebox("panel").bg_color = Color.GREEN
	else:
		تلاش.get_theme_stylebox("panel").bg_color = Color.TRANSPARENT


## هنگام لبریز شدن جام عمر بازی فراخوانی می‌شود
func پایان_بازی():
	for بچه in $پا.get_children():
		بچه.visible = true
	$"ایستاده/ادامه".hide()
	$"چهارچوب_پا".hide()
	$"پا".hide()
	$ایستاده.show()
	$سر.hide()
	$تن.hide()
	$ایستاده/امتیاز.text = str(امتیاز)
	get_tree().paused = true



## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _process(delta: float):
	if not تلاش‌ها and not $"شمارشگردرست".time_left:  # FIXME پس از آخرین تلاش بی‌درنگ بازی تمام می‌شود بدون توجه به نمایش‌درست
		$"چشمک".disconnect("timeout", چشمک)
		پایان_بازی()
	$"سر/زمان".text = "زمان: {0}".format([پارسی‌سازی.شماره_پارسی(str(int($"شمارشگر".time_left)))])


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
		while [سطر_برگزیده, ستون_برگزیده] in برگزیدگان:
			سطر_برگزیده = randi_range(1, بعدها)
			ستون_برگزیده = randi_range(1, بعدها)
		برگزیدگان.append([سطر_برگزیده, ستون_برگزیده])


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
		get_node("تن/{0}".format([بعدها])).free()
		for هرسطری in range(1, بعدها):
			get_node("تن/{0}/{1}".format([هرسطری, بعدها])).free()
		بعدها -= 1
		شمار_خانه‌ها = (بعدها ** 2)
		شمار_برگزیدگان = int(شمار_خانه‌ها / 2)
		بیشینه_شمار_برگزیدگان = int(شمار_خانه‌ها / 1.5)
		کمینه_شمار_برگزیدگان = int(شمار_خانه‌ها / 2.5)
	
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


## همان پیشرفت. چه بازیکن درست باشد و چه نادرست پیشرفت برداشت می‌شود.
## بررسی درستی بازگزینی خانه‌ها، کاهش و افزایش بعد تخته کار ایشان می‌باشد.
func پیشروی(متغیر: Array):
	برگزیدگان_بازیکن += 1
	var سطر = متغیر[0]
	var ستون = متغیر[1]
	var نوسبک = get_node("تن/{0}/{1}".format([سطر, ستون])).get_theme_stylebox("disabled").duplicate()
	if متغیر in برگزیدگان:
		$آوا.سردادن("درست")
		get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
		get_node("تن/{0}/{1}".format([سطر, ستون])).add_theme_stylebox_override("disabled", نوسبک)
		get_node("تن/{0}/{1}".format([سطر, ستون])).get("theme_override_styles/disabled").bg_color = Color.CYAN
		برگزیدگان.erase(متغیر)
	else:
		$آوا.سردادن("نادرست")
		get_node("تن/{0}/{1}".format([سطر, ستون])).add_theme_stylebox_override("disabled", نوسبک)
		get_node("تن/{0}/{1}".format([سطر, ستون])).get("theme_override_styles/disabled").bg_color = Color.HOT_PINK
		get_node("تن/{0}/{1}".format([سطر, ستون])).disabled = true
	if برگزیدگان_بازیکن == شمار_برگزیدگان:
		get_node("پا/{0}".format([تلاش‌ها])).get_theme_stylebox("panel").bg_color = Color.TRANSPARENT
		تلاش‌ها -= 1
		برگزیدگان_بازیکن = 0
		if not len(برگزیدگان):
			$آوا.سردادن("پیروزی")  #TODO: آوا را ببر تا کوتاه باشد
			شمار_برگزیدگان += 1
			if شمار_برگزیدگان == بیشینه_شمار_برگزیدگان:
				بعدها += 1
				شمار_خانه‌ها = (بعدها ** 2)
				شمار_برگزیدگان = int(شمار_خانه‌ها / 2)
				بیشینه_شمار_برگزیدگان = int(شمار_خانه‌ها / 1.5)
				کمینه_شمار_برگزیدگان = int(شمار_خانه‌ها / 2.5)
				var نوسطر = HBoxContainer.new()
				نوسطر.name = str(بعدها)
				$"تن".add_child(نوسطر)
				$"تن".get_child(بعدها - 1).size_flags_vertical = SIZE_EXPAND_FILL
				$"تن".get_child(بعدها - 1).size_flags_horizontal = SIZE_EXPAND_FILL
				for هرسطر in range(1, بعدها + 1):
					for هرستون in range(1, بعدها + 1):
						var نوستون = Button.new()
						نوستون.name = str(هرستون)
						if هرسطر == بعدها or هرستون == بعدها:
							get_node("تن/{0}".format([هرسطر])).add_child(نوستون)
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).size_flags_horizontal = SIZE_EXPAND_FILL
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).size_flags_vertical = SIZE_EXPAND_FILL
							get_node("تن/{0}/{1}".format([هرسطر, هرستون])).pressed.connect(پیشروی.bind([هرسطر, هرستون]))
			امتیاز += 1
			$"سر/امتیاز".text = "امتیاز: {0}".format([پارسی‌سازی.شماره_پارسی(str(امتیاز))])
			$"ایستاده/امتیاز".text = پارسی‌سازی.شماره_پارسی(str(امتیاز))
			نمایش()
		else:
			if $آوا.stream == preload("res://آواها/نادرست.wav"):
				$آوا.سردادن("باخت")
			if شمار_برگزیدگان > 4:
				شمار_برگزیدگان -= 1
			نمایش_درست()

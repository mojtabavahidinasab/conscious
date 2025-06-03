extends Control
var درازای_تخته :int = 3
var پهنای_تخته :int = 3
var مکان_تجسم_توپ :Dictionary = {"درازا": null, "پهنا": null}
var شمارچوبان :int = 1
var چوبان :Dictionary = {}
var تلاش‌ها = 5
var توپ_حرکت_می‌کند :bool = false
var توپ_آماده_است :bool = false
var مقصد_درست_گزیده_گشت :bool = false
var بزرگی_تندی_توپ :int = 250
var تندی_توپ :Vector2 = Vector2.ZERO
signal دکمه_فشرده_شد
signal توپ_به_مقصد_رسید


func _process(س: float):
	if توپ_حرکت_می‌کند:
		$"توپ".position += تندی_توپ * س
	if توپ_حرکت_می‌کند and !توپ_آماده_است:
		var مکان_آغاز_توپ = get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]]))
		if !$"توپ".get_rect().intersects(Rect2(مکان_آغاز_توپ.global_position, مکان_آغاز_توپ.size)):
			توپ_آماده_است = true
	if توپ_حرکت_می‌کند and توپ_آماده_است:
		for بچه in $"تخته".get_children():
			for نوه in بچه.get_children():
				if نوه is Panel:
					if نوه.modulate == Color.TRANSPARENT:
						continue
					if !نوه.has_node("ا") and !نوه.has_node("ب"):
						continue
					if $"توپ".get_rect().intersection(Rect2(نوه.global_position, نوه.size)).size >= نوه.size:
						توپ_حرکت_می‌کند = false
						$"توپ".position = نوه.global_position
						if نوه.has_node("ب"):
							نوه.get_node("ب").show()
							if تندی_توپ.x < 0:
								تندی_توپ = Vector2(0, -بزرگی_تندی_توپ)
							elif تندی_توپ.x > 0:
								تندی_توپ = Vector2(0, بزرگی_تندی_توپ)
							elif تندی_توپ.y < 0:
								تندی_توپ = Vector2(-بزرگی_تندی_توپ, 0)
							elif تندی_توپ.y > 0:
								تندی_توپ = Vector2(بزرگی_تندی_توپ, 0)
						elif نوه.has_node("ا"):
							نوه.get_node("ا").show()
							if تندی_توپ.x < 0:
								تندی_توپ = Vector2(0, بزرگی_تندی_توپ)
							elif تندی_توپ.x > 0:
								تندی_توپ = Vector2(0, -بزرگی_تندی_توپ)
							elif تندی_توپ.y < 0:
								تندی_توپ = Vector2(بزرگی_تندی_توپ, 0)
							elif تندی_توپ.y > 0:
								تندی_توپ = Vector2(-بزرگی_تندی_توپ, 0)
						توپ_حرکت_می‌کند = true
				if نوه is Button:
					if $"توپ".get_rect().intersection(Rect2(نوه.global_position, نوه.size)).size >= نوه.size:
						توپ_حرکت_می‌کند = false
						$"توپ".position = نوه.global_position
						if نوه.icon == preload(بازی.فرتورجاتوپی_برگزیده):
							مقصد_درست_گزیده_گشت = true
						توپ_به_مقصد_رسید.emit()


func _ready():
	بازی.امتیاز = 0
	theme = بازی.سبک_برگزیده
	$"سر/ایستاننده".pressed.connect($"سر".بایست.bind(get_children()))
	$"ایستاده/ادامه".pressed.connect($"ایستاده".ادامه_بازی.bind(get_children()))
	$"ایستاده/ازنو".pressed.connect($"ایستاده".بازی_ازنو)
	$"ایستاده/برگردان".pressed.connect($"ایستاده".بیرون_رفتن_ازبازی)
	await $"شمارش".آغاز
	for تلاش in تلاش‌ها:
		آماده_کردن_تخته(درازای_تخته, پهنای_تخته)
		await get_tree().create_timer(.1).timeout
		نمایش_چوبان()
		await get_tree().create_timer(4).timeout
		نمایش_چوبان(false)
		نمایش_مکان_تجسم_توپ()
		await توپ_به_مقصد_رسید
		if مقصد_درست_گزیده_گشت:
			بازی.امتیاز += 1
			شمارچوبان += 1
			if بازی.امتیاز >= (درازای_تخته * پهنای_تخته) / 3:
				if درازای_تخته == پهنای_تخته:
					درازای_تخته += 1
				else:
					پهنای_تخته += 1
			$آوا.سردادن("درست")
		else:
			$آوا.سردادن("نادرست")
		await get_tree().create_timer(2).timeout
		تخته_را_پاک_کن()
		$"توپ".hide()
		چوبان.clear()
		مقصد_درست_گزیده_گشت = false
		توپ_آماده_است = false
		await get_tree().create_timer(1).timeout
	await get_tree().create_timer(.1).timeout
	get_tree().paused = true
	$"ایستاده/ادامه".hide()
	$"تخته".hide()
	$"ایستاده".show()
	$"سر".hide()


func برگزیدن_خانه(سطر :int, ستون :int):
	$"توپ".position = get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]])).global_position
	$"توپ".show()
	توپ_حرکت_می‌کند = true
	for بچه in $"تخته".get_children():
		for نوه in بچه.get_children():
			if نوه is Button:
				نوه.disabled = true
				if نوه.name == str(ستون) and بچه.name == str(سطر):
					نوه.icon = preload(بازی.فرتورجاتوپی_برگزیده)


func نمایش_مکان_تجسم_توپ():
	get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]])).disabled = true
	if مکان_تجسم_توپ["پهنا"] == 1:
		get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]])).icon = preload(بازی.فرتورسمت_پایین)
		تندی_توپ = Vector2(0, بزرگی_تندی_توپ)
	elif مکان_تجسم_توپ["پهنا"] == درازای_تخته + 2:
		get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]])).icon = preload(بازی.فرتورسمت_بالا)
		تندی_توپ = Vector2(0, -بزرگی_تندی_توپ)
	elif مکان_تجسم_توپ["درازا"] == 1:
		get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]])).icon = preload(بازی.فرتورسمت_راست)
		تندی_توپ = Vector2(بزرگی_تندی_توپ, 0)
	elif مکان_تجسم_توپ["درازا"] == پهنای_تخته + 2:
		get_node("تخته/{0}/{1}".format([مکان_تجسم_توپ["پهنا"], مکان_تجسم_توپ["درازا"]])).icon = preload(بازی.فرتورسمت_چپ)
		تندی_توپ = Vector2(-بزرگی_تندی_توپ, 0)


func نمایش_چوبان(آشکار: bool = true):
	if آشکار:
		for چوب in چوبان.keys():
			var تجسم_چوب = Line2D.new()
			if چوبان[چوب]["نوع"] == "\\":
				تجسم_چوب.name = "ب"
				تجسم_چوب.add_point(Vector2.ZERO)
				تجسم_چوب.add_point(get_node("تخته/{0}/{1}".format([چوبان[چوب]["پهنا"], چوبان[چوب]["درازا"]])).get_rect().size)
			else:
				تجسم_چوب.name = "ا"
				تجسم_چوب.add_point(Vector2(get_node("تخته/{0}/{1}".format([چوبان[چوب]["پهنا"], چوبان[چوب]["درازا"]])).get_rect().size.x, 0))
				تجسم_چوب.add_point(Vector2(0, get_node("تخته/{0}/{1}".format([چوبان[چوب]["پهنا"], چوبان[چوب]["درازا"]])).get_rect().size.y))
			get_node("تخته/{0}/{1}".format([چوبان[چوب]["پهنا"], چوبان[چوب]["درازا"]])).add_child(تجسم_چوب)
	else:
		for چوب in چوبان.keys():
			get_node("تخته/{0}/{1}".format([چوبان[چوب]["پهنا"], چوبان[چوب]["درازا"]])).get_child(0).hide()
		for بچه in $"تخته".get_children():
			for نوه in بچه.get_children():
				if نوه is Button:
					نوه.disabled = false


func تخته_را_پاک_کن():
	for بچه in $"تخته".get_children():
		بچه.queue_free()


func آماده_کردن_تخته(درازا :int, پهنا :int):
	مکان_تجسم_توپ["پهنا"] = randi_range(1, درازا + 2)
	if مکان_تجسم_توپ["پهنا"] == 1 or مکان_تجسم_توپ["پهنا"] == درازا + 2:
		مکان_تجسم_توپ["درازا"] = randi_range(2, پهنا + 1)
	else:
		مکان_تجسم_توپ["درازا"] = [1, پهنا + 2].pick_random()
	var مکان_معتبرچوب = []
	for درازای_معتبرچوب in range(2, پهنا + 2):
		for پهنای_معتبرچوب in range(2, درازا + 2):
			مکان_معتبرچوب.append([درازای_معتبرچوب, پهنای_معتبرچوب])
	for چوب in شمارچوبان:
		var مکان_چوب = مکان_معتبرچوب.pick_random()
		مکان_معتبرچوب.erase(مکان_چوب)
		var درازای_چوب = مکان_چوب[0]
		var پهنای_چوب = مکان_چوب[1]
		var نوع_چوب = ["/", "\\"].pick_random()
		چوبان[چوب] = {"درازا": درازای_چوب, "پهنا": پهنای_چوب, "نوع": نوع_چوب}
	for سطر in range(1, درازا + 3):
		var نوسطر :HBoxContainer = HBoxContainer.new()
		نوسطر.size_flags_vertical = SIZE_EXPAND_FILL
		نوسطر.add_theme_constant_override("sepration", 4)
		نوسطر.name = str(سطر)
		for ستون in range(1, پهنا + 3):
			var نوستون
			if (سطر == 1 and ستون != 1 and ستون != پهنا + 2) \
			or (سطر == درازا + 2 and ستون != 1 and ستون != پهنا + 2) \
			or (ستون == 1 and سطر != 1 and سطر != درازا + 2) \
			or (ستون == پهنا + 2 and سطر != 1 and سطر != درازا + 2):
				نوستون = Button.new()
				نوستون.disabled = true
				نوستون.pressed.connect(برگزیدن_خانه.bind(سطر, ستون))
				نوستون.icon = preload(بازی.فرتورجاتوپی)
				نوستون.expand_icon = true
			elif (سطر == 1 or سطر == درازا + 2):
				نوستون = Panel.new()
				نوستون.modulate = Color.TRANSPARENT
			else:
				نوستون = Panel.new()
			نوستون.size_flags_horizontal = SIZE_EXPAND_FILL
			نوستون.name = str(ستون)
			نوسطر.add_child(نوستون)
		$تخته.add_child(نوسطر)

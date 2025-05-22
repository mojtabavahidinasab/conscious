extends Control
@export var طبقه: PackedScene
var امتیاز = 0
var تلاش‌ها = 7
var فرصت‌ها = 5
var نمونه‌فرصت‌ها = []
var اندازه‌فرصت = Vector2(110, 110)
var طبقه_آینه = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$"سر/ایستاننده".pressed.connect($"سر".بایست.bind(get_children()))
	$"ایستاده/ادامه".pressed.connect($"ایستاده".ادامه_بازی.bind(get_children()))
	$"ایستاده/ازنو".pressed.connect($"ایستاده".بازی_ازنو)
	$"ایستاده/برگردان".pressed.connect($"ایستاده".بیرون_رفتن_ازبازی)
	نمایش()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass


func حرکت_دوربین(نمونه):
	if $"دوربین".position.y > نمونه.position.y:
		$دوربین.position.y = نمونه.position.y
		$"سر".position = $دوربین.position - Vector2(get_parent_area_size() / 2)
		$"ایستاده".position = $"دوربین".position - $"ایستاده".get_rect().size / 2
		$شمارش.position = $"دوربین".position - $"شمارش".get_rect().size / 2


func بساز(شمارطبقات):
	if not شمارطبقات:
		$شمارش.show()
		get_tree().paused = true
		$"شمارش/شمارشگرآغاز".start()
		$آوا.سردادن("آغازشمارشگر")
	else:
		var نمونه = طبقه.instantiate()
		نمونه.position = $دوربین.position - Vector2(0, get_parent_area_size()[1] / 2)
		نمونه.connect("تماس", حرکت_دوربین.bind(نمونه))
		if طبقه_آینه:
			نمونه.get_node("ریخت").flip_h = true
		طبقه_آینه = not طبقه_آینه
		add_child(نمونه)
		$"شمارشگر".timeout.disconnect(بساز)
		$شمارشگر.timeout.connect(بساز.bind(شمارطبقات - 1))
		$"شمارشگر".start()


func پیشروی(شماره: int):
	if پارسی‌سازی.شماره_پارسی(str(شماره)) == نمونه‌فرصت‌ها.front().name:
		نمونه‌فرصت‌ها.pop_front().queue_free()
		امتیاز += 1
		$"سر/امتیاز".text = "امتیاز: {0}".format([پارسی‌سازی.شماره_پارسی(str(امتیاز))])
		$"ایستاده/امتیاز".text = پارسی‌سازی.شماره_پارسی(str(امتیاز))
		$آوا.سردادن("درست")
	else:
		$آوا.سردادن("نادرست")
		var شمارطبقات =  فرصت‌ها - len(نمونه‌فرصت‌ها)
		for نمونه in نمونه‌فرصت‌ها:
			نمونه.queue_free()
		نمونه‌فرصت‌ها.clear()
		return بساز(شمارطبقات)
	if not نمونه‌فرصت‌ها:
		return بساز(فرصت‌ها)


func پایان‌بازی():
	get_tree().paused = true
	$"ایستاده/ادامه".hide()
	$"ایستاده".show()
	$"سر".hide()


func پایان‌نمایش():
	$"شمارش/شمارشگرآغاز".timeout.disconnect($شمارش.آغازبازی)
	$"شمارش/شمارشگرآغاز".timeout.connect(نمایش)
	for نمونه in نمونه‌فرصت‌ها:
		نمونه.text = ""
		نمونه.disabled = false


func نمایش():
	if not $"شمارش/شمارشگرآغاز".time_left:
		$"شمارش".hide()
		get_tree().paused = false
		$آوا.سردادن("آغازبازی")
	if not تلاش‌ها:
		return پایان‌بازی()
	for فرصت in فرصت‌ها:
		var درازا = get_parent_area_size()[0] - اندازه‌فرصت.x
		var پهنا = $"دوربین".position.y + get_parent_area_size()[1] / 2 - اندازه‌فرصت.y
		var درازای‌فرصت = randi_range(0, درازا - اندازه‌فرصت.x)
		var پهنای‌فرصت = randi_range($دوربین.position.y, پهنا - اندازه‌فرصت.y)
		var نمونه = Button.new()
		نمونه.position = Vector2(درازای‌فرصت, پهنای‌فرصت)
		for هرفرصت in نمونه‌فرصت‌ها:
			while (نمونه.position.x >= هرفرصت.position.x - اندازه‌فرصت.x and
			نمونه.position.x <= هرفرصت.position.x + اندازه‌فرصت.x) or\
			(نمونه.position.y >= هرفرصت.position.y - اندازه‌فرصت.y and
			نمونه.position.y <= هرفرصت.position.y + اندازه‌فرصت.y):
				درازای‌فرصت = randi_range(0, درازا - اندازه‌فرصت.x)
				پهنای‌فرصت = randi_range($دوربین.position.y, پهنا - اندازه‌فرصت.y)
				نمونه.position = Vector2(درازای‌فرصت, پهنای‌فرصت)
		نمونه.size = اندازه‌فرصت
		نمونه.add_theme_stylebox_override("normal", StyleBoxFlat.new())
		نمونه.get("theme_override_styles/normal").corner_detail = 8
		نمونه.process_mode = Node.PROCESS_MODE_PAUSABLE
		نمونه.get("theme_override_styles/normal").bg_color = Color.BLACK
		نمونه.get("theme_override_styles/normal").corner_radius_top_left = 255
		نمونه.get("theme_override_styles/normal").corner_radius_top_right = 255
		نمونه.get("theme_override_styles/normal").corner_radius_bottom_left = 255
		نمونه.get("theme_override_styles/normal").corner_radius_bottom_right = 255
		نمونه.add_theme_stylebox_override("disabled", نمونه.get("theme_override_styles/normal"))
		نمونه.pressed.connect(پیشروی.bind(فرصت + 1))
		نمونه.name = پارسی‌سازی.شماره_پارسی(str(فرصت + 1))
		نمونه.text = پارسی‌سازی.شماره_پارسی(str(فرصت + 1))
		نمونه.disabled = true
		نمونه‌فرصت‌ها.append(نمونه)
		add_child(نمونه)
	تلاش‌ها -= 1
	$"شمارشگرنمایش".start()
	

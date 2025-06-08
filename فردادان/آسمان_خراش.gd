extends Control
@export var طبقه :PackedScene
@export var طبقه_پایانی :Texture = preload(بازی.فرتورطبقه_پایانی)
var تلاش‌ها = 7
var فرصت‌ها = 5
var نمونه‌فرصت‌ها = []
var اندازه‌فرصت = Vector2(110, 110)
var طبقه_آینه = false
var شماره‌های_برگزیده :Array[int] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	بازی.امتیاز = 0
	theme = بازی.سبک_برگزیده
	await $"شمارش".آغاز
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
	for هرطبقه in شمارطبقات:
		var نمونه = طبقه.instantiate()
		نمونه.position = $دوربین.position - Vector2(0, get_parent_area_size()[1] / 2)
		نمونه.connect("تماس", حرکت_دوربین.bind(نمونه))
		if هرطبقه == شمارطبقات - 1:
			نمونه.get_node("ریخت").texture = طبقه_پایانی
		add_child(نمونه)
		await get_tree().create_timer(1.8).timeout
	await get_tree().create_timer(1.8).timeout
	$شمارش.show()
	get_tree().paused = true
	$"شمارش/شمارشگرآغاز".start()
	$آوا.سردادن("آغازشمارشگر")


func پیشروی(شماره: int):
	if شماره == شماره‌های_برگزیده.front():
		نمونه‌فرصت‌ها.pop_front().queue_free()
		شماره‌های_برگزیده.pop_front()
		بازی.امتیاز += 1
		$آوا.سردادن("درست")
	else:
		$آوا.سردادن("نادرست")
		var شمارطبقات =  فرصت‌ها - len(نمونه‌فرصت‌ها)
		for نمونه in نمونه‌فرصت‌ها:
			نمونه.queue_free()
		نمونه‌فرصت‌ها.clear()
		شماره‌های_برگزیده.clear()
		await بساز(شمارطبقات)
		return 0
	if not نمونه‌فرصت‌ها:
		await بساز(فرصت‌ها)


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
	var شماره‌ها :Array[int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
	for هرفصت in فرصت‌ها:
		var شماره :int = شماره‌ها.pick_random()
		شماره‌ها.erase(شماره)
		شماره‌های_برگزیده.append(شماره)
	شماره‌های_برگزیده.sort()
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
		نمونه.pressed.connect(پیشروی.bind(شماره‌های_برگزیده[فرصت]))
		نمونه.name = پارسی‌سازی.شماره_پارسی(str(شماره‌های_برگزیده[فرصت]))
		نمونه.text = پارسی‌سازی.شماره_پارسی(str(شماره‌های_برگزیده[فرصت]))
		نمونه.disabled = true
		نمونه‌فرصت‌ها.append(نمونه)
		add_child(نمونه)
	تلاش‌ها -= 1
	$"شمارشگرنمایش".start()
	

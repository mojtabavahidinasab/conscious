extends Control
var رنگ :String = "سبز"
var جریان :String = "چپ"
var تندی_جریان :float = .1
var برگ_به_کجا_اشاره_می‌کند :String = "چپ"


func _input(رویداد :InputEvent):
	if رویداد is InputEventScreenTouch:
		if رویداد.is_released():
			پیشروی($"مهارلمس".سمت_لمس)


func _process(س :float):
	$"سر/زمان".text = "زمان: {0}".format([پارسی‌سازی.شماره_پارسی(str(int($"شمارشگر".time_left)))])


func _ready():
	بازی.امتیاز = 0
	await $"شمارش".آغاز
	پیشروی()
	$آب.show()
	$برگ.show()


func پایان_بازی():
	$سر.hide()
	$"ایستاده/ادامه".hide()
	$ایستاده.show()
	$آب.hide()
	$برگ.hide()
	get_tree().paused = true


func پیشروی(سمت_لمس :String = ""):
	if !سمت_لمس.is_empty():
		if رنگ == "سبز":
			if برگ_به_کجا_اشاره_می‌کند == سمت_لمس:
				بازی.امتیاز += 1
				$آوا.سردادن("درست")
			else:
				$آوا.سردادن("نادرست")
		elif رنگ == "نارنجی":
			if جریان == سمت_لمس:
				بازی.امتیاز += 1
				$آوا.سردادن("درست")
			else:
				$آوا.سردادن("نادرست")
	جریان = ["چپ", "پایین", "بالا", "راست"].pick_random()
	برگ_به_کجا_اشاره_می‌کند = ["چپ", "پایین", "بالا", "راست"].pick_random()
	if جریان == "چپ" and برگ_به_کجا_اشاره_می‌کند == "چپ":
		$آب.rotation_degrees = 0
		$برگ.material.set_shader_parameter("offset", Vector2(تندی_جریان, 0))
		$برگ.rotation_degrees = 0
	elif جریان == "چپ" and برگ_به_کجا_اشاره_می‌کند == "پایین":
		$آب.rotation_degrees = 0
		$برگ.material.set_shader_parameter("offset", Vector2(0, تندی_جریان))
		$برگ.rotation_degrees = 270
	elif جریان == "چپ" and برگ_به_کجا_اشاره_می‌کند == "بالا":
		$آب.rotation_degrees = 0
		$برگ.material.set_shader_parameter("offset", Vector2(0, -تندی_جریان))
		$برگ.rotation_degrees = 90
	elif جریان == "چپ" and برگ_به_کجا_اشاره_می‌کند == "راست":
		$آب.rotation_degrees = 0
		$برگ.material.set_shader_parameter("offset", Vector2(-تندی_جریان, 0))
		$برگ.rotation_degrees = 180
	elif جریان == "پایین" and برگ_به_کجا_اشاره_می‌کند == "چپ":
		$آب.rotation_degrees = 270
		$برگ.material.set_shader_parameter("offset", Vector2(0, -تندی_جریان))
		$برگ.rotation_degrees = 0
	elif جریان == "پایین" and برگ_به_کجا_اشاره_می‌کند == "پایین":
		$آب.rotation_degrees = 270
		$برگ.material.set_shader_parameter("offset", Vector2(تندی_جریان, 0))
		$برگ.rotation_degrees = 270
	elif جریان == "پایین" and برگ_به_کجا_اشاره_می‌کند == "بالا":
		$آب.rotation_degrees = 270
		$برگ.material.set_shader_parameter("offset", Vector2(-تندی_جریان, 0))
		$برگ.rotation_degrees = 90
	elif جریان == "پایین" and برگ_به_کجا_اشاره_می‌کند == "راست":
		$آب.rotation_degrees = 270
		$برگ.material.set_shader_parameter("offset", Vector2(0, تندی_جریان))
		$برگ.rotation_degrees = 180
	elif جریان == "بالا" and برگ_به_کجا_اشاره_می‌کند == "چپ":
		$آب.rotation_degrees = 90
		$برگ.material.set_shader_parameter("offset", Vector2(0, تندی_جریان))
		$برگ.rotation_degrees = 0
	elif جریان == "بالا" and برگ_به_کجا_اشاره_می‌کند == "پایین":
		$آب.rotation_degrees = 90
		$برگ.material.set_shader_parameter("offset", Vector2(-تندی_جریان, 0))
		$برگ.rotation_degrees = 270
	elif جریان == "بالا" and برگ_به_کجا_اشاره_می‌کند == "بالا":
		$آب.rotation_degrees = 90
		$برگ.material.set_shader_parameter("offset", Vector2(تندی_جریان, 0))
		$برگ.rotation_degrees = 90
	elif جریان == "بالا" and برگ_به_کجا_اشاره_می‌کند == "راست":
		$آب.rotation_degrees = 90
		$برگ.material.set_shader_parameter("offset", Vector2(0, -تندی_جریان))
		$برگ.rotation_degrees = 180
	elif جریان == "راست" and برگ_به_کجا_اشاره_می‌کند == "چپ":
		$آب.rotation_degrees = 180
		$برگ.material.set_shader_parameter("offset", Vector2(-تندی_جریان, 0))
		$برگ.rotation_degrees = 0
	elif جریان == "راست" and برگ_به_کجا_اشاره_می‌کند == "پایین":
		$آب.rotation_degrees = 180
		$برگ.material.set_shader_parameter("offset", Vector2(0, -تندی_جریان))
		$برگ.rotation_degrees = 270
	elif جریان == "راست" and برگ_به_کجا_اشاره_می‌کند == "بالا":
		$آب.rotation_degrees = 180
		$برگ.material.set_shader_parameter("offset", Vector2(0, تندی_جریان))
		$برگ.rotation_degrees = 90
	elif جریان == "راست" and برگ_به_کجا_اشاره_می‌کند == "راست":
		$آب.rotation_degrees = 180
		$برگ.material.set_shader_parameter("offset", Vector2(تندی_جریان, 0))
		$برگ.rotation_degrees = 180
	رنگ = ["سبز", "نارنجی"].pick_random()
	if رنگ == "سبز":
		$برگ.texture = preload(بازی.فرتوربرگ_سبز)
	elif رنگ == "نارنجی":
		$برگ.texture = preload(بازی.فرتوربرگ_نارنجی)

extends Control
var شماره: String
var درازا: int = 3
var کران_تلاش: int = 10
var تلاش‌ها: int = 0


func بنویس():
	تلاش‌ها += 1
	if $"تخته‌کلید".نوشتار == شماره:
		بازی.امتیاز += 1
		درازا += 1
		$آوا.سردادن("درست")
		
	else:
		$آوا.سردادن("نادرست")
	شماره = ""
	$"برچسب".show()
	$"شمارشگردرست".start()
	$"تخته‌کلید".پاک‌کن()
	$"تخته‌کلید".hide()


func پایان_بازی():
	$"برچسب".hide()
	get_tree().paused = true
	$"ایستاده/ادامه".hide()
	$"ایستاده".show()
	$"تخته‌کلید".hide()
	$سر.hide()


func پیشروی():
	$آوا.سردادن("آغازبازی")
	if تلاش‌ها == کران_تلاش:
		پایان_بازی()
	for دراز in درازا:
		شماره += str(randi_range(0, 9))
	$"برچسب".text = پارسی‌سازی.شماره_پارسی(شماره)
	$"تخته‌کلید".hide()
	$"شمارشگر".start()


func صبر():
	$"تخته‌کلید".show()
	$"برچسب".hide()


# Called when the node enters the scene tree for the first time.
func _ready():
	بازی.امتیاز = 0
	theme = بازی.سبک_برگزیده
	$"تخته‌کلید/۰/-".hide()
	$"تخته‌کلید/۰/٫".hide()
	$"تخته‌کلید/۰/✔️".pressed.connect(بنویس)
	await $"شمارش".آغاز
	پیشروی()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if $"شمارشگر".time_left:
		$"سر/زمان".text = "زمان: {0}".format([پارسی‌سازی.شماره_پارسی(str(int($"شمارشگر".time_left)))])
	else:
		$"سر/زمان".text = "زمان: {0}".format([پارسی‌سازی.شماره_پارسی(str(int($"شمارشگردرست".time_left)))])

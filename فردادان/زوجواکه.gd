extends Control
## نام این بازی در Lumosity برابر Brain Shift است
##
## اگر نام شایسته‌تری دارید، خواهشمندم پیشنهاد دهید
## نشانی برای پیشنهاد نام شایسته TODO
##
## @tutorial:             https://github.com/mojtabavahidinasab/conscious/TODO
var پرسش :String
var پرسش‌ها :Array[String] = ["زوج", "واکه", "فرد", "همخوان"]
var واج :String
var واج‌ها :Array[String] = [
	"A", "B", "C", "D",
	"E", "F", "G", "H",
	"I", "J", "K", "L",
	"M", "N", "O", "P",
	"Q", "R", "S", "T",
	"U", "V", "W", "X", 
	"Y", "Z"
]
var شماره :int

## برابر پارسی «حروف صدادار» واکه می‌باشد.
## به دانش من تنها واکه در زبان پارسی «الف» است و آن به مانند شماره یک می‌ماند.
## بنابراین فقط در این بازی از زبان قاتل بهره می‌برم.
var واکه‌ها :Array[String] = [
"A", "E", "I", 
"O", "U" 
]

## برابر پارسی «حروف بی‌صدا» هم‌خوان‌ها می‌باشد.
## در ادامه مشکل واکه‌ها در پارسی، برای یکپارچگی از هم‌خوان‌های زبان قاتل بهره می‌برم.
var همخوان‌ها :Array[String] = [
"B", "C", "D",
"F", "G", "H",
"J", "K", "L",
"M", "N", "P",
"Q", "R", "S",
"T", "V", "W",
"X", "Y", "Z"
]


func دگرگونی():
	پرسش = پرسش‌ها.pick_random()
	واج = واج‌ها.pick_random()
	شماره = randi_range(0, 9)
	var نخست_شماره :bool = [true, false].pick_random()
	var متن :String = ""
	if نخست_شماره:
		متن = "{0}{1}".format([شماره, واج])
	else:
		متن = "{0}{1}".format([واج, شماره])
	for بچه :Label in $تن.get_children():
		if بچه.name == پرسش:
			بچه.text = متن
		else:
			بچه.text = ""


## همان پیشرفت. چه بازیکن درست باشد و چه نادرست پیشرفت برداشت می‌شود.
## بررسی درستی یا نادرستی بازیکن، دگرگونی متن برچسب‌ها و برگزیدن یکی از آنان کار ایشان می‌باشد.
func پیشروی(پاسخ :bool):
	var درستی :bool
	if پرسش == "زوج":
		درستی = شماره % 2 == 0
	elif پرسش == "فرد":
		درستی = شماره % 2 == 1
	elif پرسش == "واکه":
		درستی = واج in واکه‌ها
	elif پرسش == "همخوان":
		درستی = واج in همخوان‌ها
	if پاسخ == درستی:
		$آوا.سردادن("درست")
		بازی.امتیاز += 1
	else:
		$آوا.سردادن("نادرست")
	دگرگونی()
	if بازی.امتیاز >= 10:
		$راهنما.hide()


## در آغازبازی یکبار متن‌های برچسب‌ها را دگرگون ساز.
## تا با هر بازآغاز همان متن‌های بازی پیش بازگو نگردند.
## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _ready():
	if بازی.بازی_درجریان == "زوجواکه":
		پرسش‌ها.erase("فرد")
		پرسش‌ها.erase("همخوان")
		$"تن/فرد".hide()
		$"تن/همخوان".hide()
		$تن.columns = 1
		$"راهنما/بالا/واکه".hide()
		$"راهنما/پایین/فرد".hide()
		$"راهنما/پایین/همخوان".text = "واکه (صدادار)"
	بازی.امتیاز = 0
	theme = بازی.سبک_برگزیده
	await $"شمارش".آغاز
	دگرگونی()


## نام این تابع یک واژه کلیدی می‌باشد برای همین نمی‌توان نامی فارسی جایگزین آن نمود.
func _process(delta: float):
	$سر/زمان.text = "زمان: {0}".format([پارسی‌سازی.شماره_پارسی(str(int($"شمارشگر".time_left)))])


## هنگام لبریز شدن جام عمر بازی فراخوانی می‌شود
func پایان_بازی():
	$راهنما.hide()
	$"ایستاده/ادامه".hide()
	$ایستاده.show()
	$سر.hide()
	$پا.hide()
	$تن.hide()
	get_tree().paused = true

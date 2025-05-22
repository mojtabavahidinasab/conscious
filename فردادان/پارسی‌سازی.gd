extends Node
class_name پارسی‌سازی


static var شمارگان = {
	".": "٫",  # 1.2 = ۱٫۲ 
	"0": "۰",
	"1": "۱",
	"2": "۲",
	"3": "۳",
	"4": "۴",
	"5": "۵",
	"6": "۶",
	"7": "۷",
	"8": "۸",
	"9": "۹"
}


static func شماره_پارسی(رشته: String, کمانک‌دادن: bool = false) -> String:
	for i in len(رشته):
		if رشته[i] in شمارگان.keys().map(str):
			رشته[i] = شمارگان[رشته[i]]
	if رشته.begins_with("-") and کمانک‌دادن:
		رشته = "(" + رشته + ")"
	return رشته

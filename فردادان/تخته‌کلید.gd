extends VBoxContainer
class_name تخته‌کلید
var نوشتار: String


func _ready():
	theme = بازی.سبک_برگزیده


func اعشاربده():
	if "." in نوشتار:
		نوشتار[نوشتار.find(".")] = ""
		$"نوشتار".text = پارسی‌سازی.شماره_پارسی(نوشتار)
	else:
		نوشتار += "."
		$"نوشتار".text += پارسی‌سازی.شماره_پارسی(".")


func علامت_بده():
	if نوشتار.begins_with("-"):
		نوشتار[0] = ""
		$"نوشتار".text = پارسی‌سازی.شماره_پارسی(نوشتار)
	else:
		نوشتار = "-" + نوشتار
		$"نوشتار".text = پارسی‌سازی.شماره_پارسی(نوشتار)


func پاک‌کن():
	نوشتار = ""
	$"نوشتار".text = نوشتار


func بنویس(نویسه):
	نوشتار += str(نویسه)
	$"نوشتار".text = پارسی‌سازی.شماره_پارسی(نوشتار)

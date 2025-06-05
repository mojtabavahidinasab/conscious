extends HBoxContainer


func _process(س: float):
	$"امتیاز".text = "امتیاز: {0}".format([پارسی‌سازی.شماره_پارسی(str(بازی.امتیاز))])


func _ready():
	theme = بازی.سبک_برگزیده


func بایست():
	$آوا.سردادن("دکمه")
	for بچه in get_parent().get_children():
		if بچه.name == "ایستاده":
			بچه.show()
		elif بچه.has_method("hide"):
			بچه.hide()
	get_tree().paused = true

extends VBoxContainer


func _process(س :float):
	$"امتیاز".text = پارسی‌سازی.شماره_پارسی(str(بازی.امتیاز))


func _ready():
	theme = بازی.سبک_برگزیده


func ادامه_بازی():
	$آوا.سردادن("دکمه")
	for بچه in get_parent().get_children():
		if بچه.has_method("show") and بچه.name != "شمارش":
			بچه.show()
	hide()
	get_tree().paused = false


func بازی_ازنو():
	$آوا.سردادن("دکمه")
	get_tree().paused = false
	get_tree().reload_current_scene()


func بیرون_رفتن_ازبازی():
	$آوا.سردادن("دکمه")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://صحنه‌ها/سرآغاز.tscn")

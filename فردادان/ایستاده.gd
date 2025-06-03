extends VBoxContainer


func _process(س :float):
	$"امتیاز".text = پارسی‌سازی.شماره_پارسی(str(بازی.امتیاز))


func _ready():
	theme = بازی.سبک_برگزیده


func ادامه_بازی(چیزها: Array):
	$آوا.سردادن("دکمه")
	for چیز in چیزها:
		if چیز.has_method("show") and چیز.name != "شمارش":
			چیز.show()
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

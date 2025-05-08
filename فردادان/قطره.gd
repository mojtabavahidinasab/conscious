extends RigidBody2D
var پاسخ
var ضریب_امتیاز
var کار


func بروزرسانی(کارش, شماره۱ش, شماره۲ش, پاسخش, ضریب):
	$"ریاضی/کار".text = کارش
	$"ریاضی/شماره۱".text = str(شماره۱ش)
	if شماره۲ش < 0:
		$"ریاضی/شماره۲".text = "(" + str(شماره۲ش) + ")"
	else:
		$"ریاضی/شماره۲".text = str(شماره۲ش)
	پاسخ = پاسخش
	کار = کارش
	ضریب_امتیاز = ضریب


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass

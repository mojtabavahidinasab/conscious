extends Node
static var مکان_لمس_نخست :Vector2 = Vector2.ZERO
static var مکان_لمس_دوم :Vector2 = Vector2.ZERO
static var جابجایی :Vector2 = Vector2.ZERO
static var سمت_لمس :String = ""


func _input(رویداد :InputEvent):
	if رویداد is InputEventScreenTouch:
		if !رویداد.is_released():
			مکان_لمس_نخست = رویداد.position
		if رویداد.is_released():
			مکان_لمس_دوم = رویداد.position
			جابجایی = مکان_لمس_نخست - مکان_لمس_دوم
			if جابجایی == Vector2.ZERO:
				سمت_لمس = ""
				return 0
			if abs(جابجایی.x) > abs(جابجایی.y):
				if جابجایی.x > 0:
					سمت_لمس = "چپ"
				else:
					سمت_لمس = "راست"
			elif abs(جابجایی.x) < abs(جابجایی.y):
				if جابجایی.y > 0:
					سمت_لمس = "بالا"
				else:
					سمت_لمس = "پایین"

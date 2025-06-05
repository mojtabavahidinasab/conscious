extends AudioStreamPlayer


func سردادن(ندا: String):
	if !بازی.پخش_آوا:
		return 1
	if ندا == "دکمه":
		stream = load([بازی.آوای_دکمه۱, بازی.آوای_دکمه۲].pick_random())
		play()
	elif ندا == "آغازشمارشگر":
		stream = preload(بازی.آوای_آغازشمارشگر)
		play()
	elif ندا == "آغازبازی":
		stream = preload(بازی.آوای_آغازبازی)
		play()
	elif ندا == "پایان بازی":
		pass
	elif ندا == "درست":
		stream = preload(بازی.آوای_درست)
		play()
	elif ندا == "نادرست":
		stream = preload(بازی.آوای_نادرست)
		play()
	elif ندا == "باخت":
		stream = preload(بازی.آوای_باخت)
		play()
	elif ندا == "پیروزی":
		stream = preload(بازی.آوای_پیروزی)
		play()
	else:
		push_warning("آوای {0} ناشناخته می‌باشد".format([ندا]))

extends AudioStreamPlayer
class_name آوای


func سردادن(ندا: String):
	if ندا == "دکمه":
		var دکمه۱ = preload("res://آواها/دکمه/بشکن۱.wav")
		var دکمه۲ = preload("res://آواها/دکمه/بشکن۲.wav")
		stream = [دکمه۱, دکمه۲].pick_random()
		play()
	elif ندا == "آغازشمارشگر":
		stream = preload("res://آواها/شمارشگرآغاز.wav")
		play()
	elif ندا == "آغازبازی":
		stream = preload("res://آواها/آغاز.mp3")
		play()
	elif ندا == "پایان بازی":
		pass
	elif ندا == "درست":
		stream = preload("res://آواها/درست.ogg")
		play()
	elif ندا == "نادرست":
		stream = preload("res://آواها/نادرست.wav")
		play()
	elif ندا == "باخت":
		stream = preload("res://آواها/باخت.wav")
		play()
	elif ندا == "پیروزی":
		stream = preload("res://آواها/پیروزی۱.wav")
		play()
	else:
		push_warning("آوای {0} ناشناخته می‌باشد".format([ندا]))

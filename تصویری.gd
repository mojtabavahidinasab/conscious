extends Control
var points = 0
var rows = 3
var cols = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	for row in range(rows):
		$MiddleMenu.add_child(HBoxContainer.new())
		
	for c in len($MiddleMenu.get_children()):
		for col in range(cols):
			$MiddleMenu.get_child(c).add_child(Button.new())
	
	print($MiddleMenu.get_children(true))


func _on_stop_pressed() -> void:
	if $Timer.paused:
		$TopMenu/Stop.text = "  | |  "
	else:
		$TopMenu/Stop.text = "  <  "
	$Timer.paused = not $Timer.paused
	$StopMenu.visible = not $StopMenu.visible
	$StopMenu/Points.text = str(points)
	$MiddleMenu.visible = not $MiddleMenu.visible


func _on_timer_timeout() -> void:
	$StopMenu.show()
	$TopMenu.hide()
	$MiddleMenu.hide()
	$StopMenu/Points.text = str(points)


func _on_countdown_timer_timeout() -> void:
	$Countdown.hide()
	$TopMenu/Stop.disabled = false
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://start_menu.tscn")

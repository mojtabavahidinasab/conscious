extends RigidBody2D
signal تماس


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_contact_count() == 2:
		emit_signal("تماس")

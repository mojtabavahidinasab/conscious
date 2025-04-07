extends Control


#var language = "Persian"
#if language == "automatic":
	#var perferred_languages = OS.get_locale_language()
	#TranslationServer.set_locale(perferred_language)
#else:
	#TranslationServer.set_locale(language)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _رنگومتن() -> void:
	get_tree().change_scene_to_file("res://رنگومتن.tscn")


func _تصویری() -> void:
	get_tree().change_scene_to_file("res://تصویری.tscn")


func _زوجواکه() -> void:
	get_tree().change_scene_to_file("res://زوجواکه.tscn")

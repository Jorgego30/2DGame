extends Control

@export var siguiente : String = "res://escenas/Niveles/Nivel1/nivel_1.tscn"

func _on_Salir_pressed():
	get_tree().quit()
	

func _on_Huir_pressed() -> void:
	get_tree().change_scene_to_file(siguiente)

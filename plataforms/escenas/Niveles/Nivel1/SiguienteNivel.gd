extends Area2D


@export var siguiente : String = "res://escenas/Niveles/Nivel2/nivel_2.tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body):
	if body.is_in_group("Personaje"):
		get_tree().change_scene_to_file(siguiente)

extends StaticBody2D

@export var camara: Camera2D
@export var offset: float = -10 #al hacer @export hace q aparezca en el inspector para q sea facil modif.

func _physics_process(delta: float) -> void:
	position.x = camara.position.x + offset

extends Camera2D

@export var _jugador : Node2D 
@export var _desplazamiento = -30

func _physics_process(delta: float) -> void:
	position.x = _jugador.position.x + _desplazamiento

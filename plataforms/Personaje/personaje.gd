extends CharacterBody2D

# func _process(delta): Esta funcion se llama a si misma constantemente una vez por cada frame
	#Delta es el tiempo en segundos que a tardado en renderizarse el frame anterior
	
#	position.x += 10 * delta #Al multiplicarlo por delta el personaje se movera 1 solo pixel por segundo
	
#La función _physics_process(delta) es llamada automáticamente por el motor de Godot
#a una frecuencia fija (normalmente 60 veces por segundo), cuando se actualizan
#las físicas.

#Se utiliza en lugar de _process() para manejar movimiento, colisiones y lógica
#que depende de la física, ya que se ejecuta de forma estable e independiente de
#los FPS del ordenador.

#Esto permite que el personaje interactúe correctamente con las físicas,
#aunque el rendimiento del equipo varíe.
@export var _animacion : AnimatedSprite2D
@export var _animacionBorrable : Array[AnimatedSprite2D] = []
@export var _velocidad: float = 200.0 #para crear variables: var _variable: tipo = valor
@export var _velocidad_salto: float = -800.0
var _puede_mover : bool = true



func _physics_process(delta):
	#Comprobamos si el jugador se puede mover
	if not _puede_mover:
		velocity = Vector2.ZERO
		return
		
	#gravedad
	velocity += get_gravity() * delta #Si no se asignan valores si se multiplica por delta 
										#en este caso estamos sumando la gravedad
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _velocidad_salto
	if Input.is_key_pressed(KEY_D):
		_animacion.flip_h = true
		velocity.x = _velocidad
	elif Input.is_key_pressed(KEY_A):
		_animacion.flip_h = false
		velocity.x = -_velocidad
	else:
		velocity.x = 0
		_animacion.play("Idle")
		
	if velocity.x != 0:
		_animacion.play("Correr")
	move_and_slide()













func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

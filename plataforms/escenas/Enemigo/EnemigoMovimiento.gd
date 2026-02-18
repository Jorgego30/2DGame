extends CharacterBody2D

@export var _jugador : CharacterBody2D
@export var _animacion : AnimatedSprite2D
@export var _velocidad_enemigo : float = 100.0
@export var _audio : AudioStreamPlayer2D
var _velocidad_salto: float = -550.0

var esperando : bool = false

func _physics_process(delta: float) -> void:
	
	velocity += get_gravity() * delta
	
	if _jugador == null:
		return

	if not esperando and _jugador.position.y < position.y - 20 and is_on_floor():
		 
		esperar_y_saltar()
		
	if(velocity.x!=0):
		_animacion.play("correr")
	else:
		_animacion.play("idle")
	if _jugador.position.x < position.x:
		_animacion.flip_h = false
		velocity.x = -_velocidad_enemigo
	
	elif _jugador.position.x > position.x :
		_animacion.flip_h = true
		velocity.x = _velocidad_enemigo
	move_and_slide()
	
func esperar_y_saltar():
	esperando = true
	await get_tree().create_timer(1.7).timeout
	velocity.y = _velocidad_salto
	if not _audio.playing:
		_audio.play()
	esperando = false

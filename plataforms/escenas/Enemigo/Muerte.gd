extends Area2D

@export var _siguiente : String = "res://escenas/Niveles/Nivel1/nivel_1.tscn"
@export var enemigo : CharacterBody2D 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body):
	
	if body.is_in_group("Personaje"):
		#Desactivamos las funciones del enemigo
		enemigo.set_physics_process(false)
		#Cojemos la animacion del jugador(va por nombre del archivo)
		var _animacion :AnimatedSprite2D = body.get_node("AnimatedSprite2D") 
		#Le damos la vuelta, bloqueamos el movimiento y aplicamos un timer para que se vea la animacion
		body._puede_mover = false
		body.set_physics_process(false)
		
		#Desactiva toda colision
		var colision = body.get_node_or_null("CollisionShape2D")
		colision.set_deferred("disabled", true)
		
		# Creamos un movimiento suave hacia arriba
		var tween = create_tween()
		# Mueve la posición Y actual a (posición actual - 100 píxeles) en 1 segundo
		tween.tween_property(body, "position:y", body.position.y - 200, 1.0)
		_animacion.flip_v = true
		# Mueve la posición Y actual a (posición actual + 400 píxeles) en 1 segundo
		tween.tween_property(body, "position:y", body.position.y +900, 0.7)
		#Esperamos 2 segundos para q vea la animacion
		await get_tree().create_timer(2).timeout
		#Cambiamos de escena
		get_tree().change_scene_to_file(_siguiente)

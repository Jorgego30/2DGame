extends Area2D

# 1. Ajustes en el Inspector
@export var escena_ragdoll: PackedScene 
@export var fuerza_explosion: float = 700.0
@export var intensidad_temblor: float = 15.0

func _ready():
	# Conectamos la señal de detección
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	# Verificamos si tocamos la cabeza del personaje
	if area.name == "AreaCabeza":
		var personaje = area.get_parent()
		
		if personaje and not personaje.is_queued_for_deletion():
			ejecutar_impacto_total(personaje)

func ejecutar_impacto_total(personaje: Node2D):
	# --- A. EFECTO DE IMPACTO ---
	Engine.time_scale = 0.05
	
	# --- B. TEMBLOR DE CÁMARA ---
	var camara = get_viewport().get_camera_2d()
	if camara and camara.has_method("shake"):
		camara.shake(15.0) # Intensidad del temblor
	
	# --- C. INSTANCIAR RAGDOLL ---
	if escena_ragdoll:
		var ragdoll = escena_ragdoll.instantiate()
		ragdoll.global_position = personaje.global_position
		
		# --- EL CAMBIO CLAVE ---
		# Lo enviamos al fondo para que el Shader de la cámara se dibuje encima
		ragdoll.z_index = -10 
		# ----------------------
		
		get_tree().current_scene.call_deferred("add_child", ragdoll)
		
		var cabeza = ragdoll.get_node_or_null("Cabeza")
		var cuerpo = ragdoll.get_node_or_null("Cuerpo")
		
		if cabeza is RigidBody2D:
			cabeza.linear_velocity = Vector2(randf_range(500, 800), randf_range(-700, -400))
		if cuerpo is RigidBody2D:
			cuerpo.linear_velocity = Vector2(randf_range(-800, -500), randf_range(-600, -300))
	
	personaje.queue_free()
	
	await get_tree().create_timer(0.1, true, false, true).timeout
	Engine.time_scale = 1.0

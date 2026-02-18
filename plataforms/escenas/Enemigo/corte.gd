extends Node2D

@export var speed: float = 4000.0 # Velocidad del corte
@export var linea: Line2D
@export var audio: Array[AudioStreamPlayer] = []
@export var jugador: CharacterBody2D
@export var carpeta: Node2D
@export var cooldown_time: float = 0.1 # Tiempo de cooldown en segundos
@export var colision: CollisionShape2D
var cd: bool = false
var atacando: bool = false

func _ready():
	jugador = get_tree().get_first_node_in_group("Personaje")
	position.x = -700
	if linea:
		scale.x = 0

func _input(event):
	if Input.is_action_just_pressed("R"):
		if not atacando and not cd:  #Solo si no está en cooldown
			audio[1].play()
			ejecutar_ataque()

func ejecutar_ataque():
	atacando = true
	cd = true  #Activamos cooldown

	# Resetear la línea y posición
	scale.x = 0
	position = Vector2.RIGHT * -700
	randomize()
	position.y = randf_range(-300, 50)
	if jugador:
		look_at(jugador.global_position)

	# Delay antes de iniciar el ataque
	await get_tree().create_timer(1.7).timeout

func _physics_process(delta):
	if atacando:
		colision.disabled = true
		if scale.x < 1300:
			scale.x += speed * delta
		else:
			scale.x = 1300
			finalizar_ataque()

func finalizar_ataque():
	atacando = false

	# Forzamos que el audio suene aunque el padre esté escalado
	#audio[0].top_level = true
	#audio[0].global_scale = Vector2(1, 1)
	audio[0].play()
	var tween = create_tween()
	tween.tween_property(linea, "width", 10.0, 0.24)
	colision.disabled = false
	await get_tree().create_timer(0.5).timeout
	linea.width = 2
	scale.x = 0

	# ✅ Iniciamos cooldown
	await get_tree().create_timer(cooldown_time).timeout
	cd = false  # Fin del cooldown

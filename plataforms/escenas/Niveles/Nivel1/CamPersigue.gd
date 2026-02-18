extends Camera2D

@export var velCam : int = 100
@export var muerteBlur: CanvasItem # Arrastra aquí el ColorRect que tiene el shader

var parar: bool = false
var shake_intensity = 0.0

func _process(delta: float) -> void:
	# 1. Movimiento constante de la cámara
	if not parar:
		position.x += velCam * delta
	
	# 2. Lógica del Shake (Temblor) usando OFFSET
	# El offset mueve la imagen sin cambiar la 'position' real
	if shake_intensity > 0:
		offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_intensity
		shake_intensity *= 0.95
		if shake_intensity < 0.1:
			shake_intensity = 0
			offset = Vector2.ZERO
	else:
		offset = Vector2.ZERO

func shake(amount: float):
	shake_intensity = amount
	parar = true # Detenemos el avance de la cámara
	activar_efecto_muerte()

# Dentro de tu función activar_efecto_muerte()
func activar_efecto_muerte():
	if muerteBlur:
		
		# --- EL CAMBIO CLAVE ---
		# Nos aseguramos de que el blur esté por encima de todo el mundo 2D
		muerteBlur.z_index = 100 
		muerteBlur.show()
		# Esto hace que ignore la posición de la cámara y use la de la pantalla
		if muerteBlur is Control:
			muerteBlur.top_level = true 
		# ----------------------

		var mat = muerteBlur.material
		if mat:
			var tween = create_tween()
			tween.tween_property(mat, "shader_parameter/lod", 2.5, 0.6)
			tween.parallel().tween_property(mat, "shader_parameter/color_tinte", Color(1, 0, 0, 0.4), 0.6)

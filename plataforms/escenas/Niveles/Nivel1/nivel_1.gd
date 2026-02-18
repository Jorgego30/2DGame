extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lanzar_corte()
	
func lanzar_corte():
	var corte = preload("res://escenas/Enemigo/Corte.tscn").instantiate()
	var cam = get_viewport().get_camera_2d()
	var screen_size = get_viewport_rect().size
	
	var half_w = screen_size.x / 2
	var half_h = screen_size.y / 2
	
	var lado = randi() % 4
	
	match lado:
		0: # IZQUIERDA
			corte.global_position = cam.global_position + Vector2(-half_w - 50, 0)
			corte.direction = Vector2.RIGHT
		
		1: # DERECHA
			corte.global_position = cam.global_position + Vector2(half_w + 50, 0)
			corte.direction = Vector2.LEFT
		
		2: # ARRIBA
			corte.global_position = cam.global_position + Vector2(0, -half_h - 50)
			corte.direction = Vector2.DOWN
		
		3: # ABAJO
			corte.global_position = cam.global_position + Vector2(0, half_h + 50)
			corte.direction = Vector2.UP
	
	add_child(corte)

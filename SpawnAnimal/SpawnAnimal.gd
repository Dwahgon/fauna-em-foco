extends Node2D

const CENA_ANIMAL = preload("res://Animais/Animal.tscn")

export(Array, int) var animais_spawnaveis = []
export(Vector2) var min_max_tempo_spawn := Vector2.ONE
export(Vector2) var min_max_tempo_desaparecer := Vector2.ONE
export(Vector2) var min_max_spawn_por_rodada := Vector2.ONE

var retangulo_spawn: Rect2


func _ready():
	var formato = $CollisionShape2D.shape.extents
	retangulo_spawn = Rect2($CollisionShape2D.global_position - formato, formato * 2)
	_iniciar_timer()


func _iniciar_timer():
	randomize()
	$Timer.start(rand_range(min_max_tempo_spawn.x, min_max_tempo_spawn.y))


func _spawnar_animal():
	randomize()
	var id_animal = animais_spawnaveis[randi() % animais_spawnaveis.size()]
	var pos = retangulo_spawn.position + Vector2(randf() * retangulo_spawn.size.x, randf() * retangulo_spawn.size.y)
	var instance_animal = CENA_ANIMAL.instance()
	
	instance_animal.global_position = pos
	instance_animal.id_animal = id_animal
	instance_animal.tempo_desaparecer = rand_range(min_max_tempo_desaparecer.x, min_max_tempo_desaparecer.y)
	instance_animal.animar_aparecendo()
	get_parent().call_deferred("add_child", instance_animal)
	_iniciar_timer()


func _on_Timer_timeout():
	randomize()
	for _i in range(rand_range(min_max_spawn_por_rodada.x, min_max_spawn_por_rodada.y)):
		_spawnar_animal()

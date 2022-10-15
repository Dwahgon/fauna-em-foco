extends Node2D

export(Vector2) var tamanho_foto: Vector2 = Vector2.ZERO
export(String) var nome_foto = "imagem"

onready var _viewport = get_viewport()

signal foto_tirada(imagem, objetos_na_foto)

func _ready():
	$Area2D/CollisionShape2D.shape.extents = tamanho_foto / 2
	$Sprite.scale = tamanho_foto / 10

func _process(_delta):
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("ui_accept"):
		var posicao_tela := get_global_transform_with_canvas().origin
		var retangulo_viewport = get_viewport_rect()
		var posicao_foto = Vector2(posicao_tela.x - tamanho_foto.x / 2, retangulo_viewport.size.y - posicao_tela.y - tamanho_foto.y / 2)
		var retangulo_captura := Rect2(posicao_foto, tamanho_foto)
		var imagem: Image = _viewport.get_texture().get_data().get_rect(retangulo_captura)
		imagem.flip_y()
		var _err := imagem.save_png("user://%s.png" % nome_foto)
		var objetos = $Area2D.get_overlapping_areas()
		print(objetos)
		emit_signal("foto_tirada", imagem, objetos)
		
	
	

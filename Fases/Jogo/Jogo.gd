extends Node

const CENA_POLAROID = preload("res://Polaroid/Polaroid.tscn")
const CAMINHO_CENA_ALBUM_FOTOS = "res://Interface/AlbumFotos/AlbumFotos.tscn"
const NOME_FOTO = "imagem%d"

onready var maquina_fotografica = $ViewportJogo/MundoJogo/MaquinaFotografica

var fitas_restantes: int

signal fitas_restantes_atualizada(qnt)

func _ready():
	fitas_restantes = Globais.quantidade_fitas
	emit_signal("fitas_restantes_atualizada", fitas_restantes)
	Globais.fotos_tiradas.clear()
	_atualizar_nome_foto()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Interface/Fade.reproduzir_fadeout()


func _on_MaquinaFotogrfica_foto_tirada(nome_imagem, _objetos_na_foto):
	if fitas_restantes > 0:
		fitas_restantes = int(clamp(fitas_restantes - 1, 0, fitas_restantes))
		
		_atualizar_nome_foto()
		emit_signal("fitas_restantes_atualizada", fitas_restantes)
		
		_adicionar_foto(nome_imagem, _objetos_na_foto)
		
		_criar_polaroid(maquina_fotografica.position, nome_imagem)
		if fitas_restantes == 0:
			$Interface/Fade.reproduzir_animacao()
			yield($Interface/Fade, "fade_in_finalizado")
			var _err = get_tree().change_scene(CAMINHO_CENA_ALBUM_FOTOS)


func _atualizar_nome_foto():
	maquina_fotografica.nome_foto = NOME_FOTO % (Globais.quantidade_fitas-fitas_restantes)


func _criar_polaroid(posicao, nome_imagem):
	var novo_polaroid = CENA_POLAROID.instance()
	
	add_child(novo_polaroid)
	
	novo_polaroid.definir_imagem(Globais.CAMINHO_FOTO % nome_imagem)
	novo_polaroid.position = posicao
	novo_polaroid.animar_aparecendo()


func _adicionar_foto(nome_imagem, objetos):
	var id_animais = []
	for objeto in objetos:
		if "id_animal" in objeto:
			id_animais.append(objeto.id_animal)
	Globais.fotos_tiradas.append({
		"nome": nome_imagem,
		"animais": id_animais
	})
	
func _process(_delta):
	$Interface/TempoRestante.text=str(int($Timer.time_left))
	
func _on_Timer_timeout():
	var _err = get_tree().change_scene(CAMINHO_CENA_ALBUM_FOTOS)

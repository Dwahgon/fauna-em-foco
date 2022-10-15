extends Node

const CENA_POLAROID = preload("res://Polaroid/Polaroid.tscn")

export (int) var quantidade_fitas := 10
var fitas_restantes

signal fitas_restantes_atualizada(qnt)

func _ready():
	fitas_restantes = quantidade_fitas
	emit_signal("fitas_restantes_atualizada", fitas_restantes)

func _on_MaquinaFotogrfica_foto_tirada(imagem, _objetos_na_foto):
	fitas_restantes -= 1
	emit_signal("fitas_restantes_atualizada", fitas_restantes)
	_criar_polaroid($ViewportJogo/MundoJogo/MaquinaFotografica.position, imagem)
	if fitas_restantes == 0:
		print("Jogo acabou!")

func _criar_polaroid(posicao, img):
	var novo_polaroid = CENA_POLAROID.instance()
	add_child(novo_polaroid)
	novo_polaroid.definir_imagem("user://%s.png" % img)
	novo_polaroid.position = posicao

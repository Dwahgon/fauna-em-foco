extends Node


export (int) var quantidade_fitas := 10
var fitas_restantes

signal fitas_restantes_atualizada(qnt)

func _ready():
	fitas_restantes = quantidade_fitas
	emit_signal("fitas_restantes_atualizada", fitas_restantes)

func _on_MaquinaFotogrfica_foto_tirada(_imagem, _objetos_na_foto):
	fitas_restantes -= 1
	emit_signal("fitas_restantes_atualizada", fitas_restantes)
	if fitas_restantes == 0:
		print("Jogo acabou!")
	

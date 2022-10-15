extends Label

export(String) var texto_rotulo = "Fitas restantes: %d"


func _ready():
	text = texto_rotulo % 0

func atualizar_fitas_restantes(quantidade: int):
	text = texto_rotulo % quantidade

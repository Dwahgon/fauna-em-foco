extends Node

const CAMINHO_JSON_ANIMAIS = "res://Assets/animal_list.json"
const CAMINHO_FOTO = "user://%s.png"
const MULTIPLICADOR_PONTO = 10

var fotos_tiradas: Array = []
var dados_animais: Dictionary

var quantidade_fitas = 5

func _ready():
	_carregar_json()


func _carregar_json():
	var arquivo = File.new()
	arquivo.open(CAMINHO_JSON_ANIMAIS, File.READ)
	var resultado_json := JSON.parse(arquivo.get_as_text())
	if resultado_json.error == OK:
		dados_animais = resultado_json.result


func calcular_pontuacao():
	var pontuacao = 0
	for foto in fotos_tiradas:
		for id_animal in foto["animais"]:
			pontuacao += MULTIPLICADOR_PONTO * (dados_animais[str(id_animal)]["nivel"] + 1)
	return pontuacao

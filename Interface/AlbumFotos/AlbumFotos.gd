extends Control

const NODE_TEXTO_DESCRICAO = "%TextoDescricao"
const NODE_TEXTO_TITULO = "%TextoTitulo"
const NODE_BOTAO_VOLTAR = "%BotaoVoltar"
const NODE_BOTAO_CONTINUAR = "%BotaoContinuar"
const NODE_GRADE_FOTOS = "%GradeFotos"
const NODE_PONTUACAO = "%Pontuacao"
const CAMINHO_CENA_JOGO = "res://Fases/Jogo/Jogo.tscn"
const CAMINHO_MENU_INICIAL = "res://Interface/MenuInicial/MenuInicial.tscn"
const CENA_POLAROID_UI = preload("res://Interface/AlbumFotos/PolaroidUI.tscn")

var id_animais = []
var pagina_atual = -1

func _ready():
	get_node(NODE_PONTUACAO).text = "Sua pontuacao: %d" % Globais.calcular_pontuacao()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	for elemento in Globais.fotos_tiradas:
		var animais = elemento["animais"]
		for animal in animais:
			if not animal in id_animais:
				id_animais.append(animal)
	id_animais.sort()
	
	$TelaAlbum.visible = id_animais.size() > 0
	$TelaAlbumVazia.visible = not $TelaAlbum.visible
	
	if id_animais.size() > 0:
		pagina_atual = 0
		
	atualizar_pagina()


func atualizar_pagina():
	if pagina_atual < 0:
		return
		
	var id_animal = id_animais[pagina_atual]
	var dados_animal = Globais.dados_animais[str(id_animal)]
	
	get_node(NODE_TEXTO_TITULO).text = dados_animal["nome"]
	get_node(NODE_TEXTO_DESCRICAO).text = dados_animal["descricao"]
	get_node(NODE_BOTAO_VOLTAR).disabled = pagina_atual <= 0
	get_node(NODE_BOTAO_CONTINUAR).disabled = pagina_atual >= id_animais.size() - 1
	
	for filho in get_node(NODE_GRADE_FOTOS).get_children():
		filho.queue_free()
	for foto in Globais.fotos_tiradas:
		if id_animal in foto["animais"]:
			var novo_polaroid = CENA_POLAROID_UI.instance()
			get_node(NODE_GRADE_FOTOS).add_child(novo_polaroid)
			novo_polaroid.definir_imagem(Globais.CAMINHO_FOTO % foto["nome"])


func _on_BotaoVoltar_pressed():
	if pagina_atual > 0:
		pagina_atual -= 1
		atualizar_pagina()


func _on_BotaoContinuar_pressed():
	if pagina_atual < id_animais.size() - 1:
		pagina_atual += 1
		atualizar_pagina()


func _on_BotaoIrParaJogo_pressed():
	var _err = get_tree().change_scene(CAMINHO_CENA_JOGO)


func _on_BotaoIrMenuPrincipal_pressed():
	var _err = get_tree().change_scene(CAMINHO_MENU_INICIAL)

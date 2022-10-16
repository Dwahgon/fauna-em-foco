extends Control

const CENA_JOGO = "res://Fases/Jogo/Jogo.tscn"
var botoes_travados = false

func _ready():
	$AvisoEpilepsia.visible = true




func _travar_botoes():
	if botoes_travados:
		return true
	botoes_travados = true
	return false


func _on_TimerAvisoEpilepsia_timeout():
	$Fade.reproduzir_animacao()
	yield($Fade, "fade_in_finalizado")
	$AvisoEpilepsia.visible = false
	$MenuPrincipal.visible = true


func _on_BotaoSair_pressed():
	if _travar_botoes():
		return
	$Fade.reproduzir_animacao()
	yield($Fade, "fade_in_finalizado")
	botoes_travados = false
	get_tree().quit()


func _on_BotaoJogar_pressed():
	if _travar_botoes():
		return
	$Fade.reproduzir_animacao()
	yield($Fade, "fade_in_finalizado")
	botoes_travados = false
	var _err = get_tree().change_scene(CENA_JOGO)


func _on_VoltarCreditos_pressed():
	if _travar_botoes():
		return
	$Fade.reproduzir_animacao()
	yield($Fade, "fade_in_finalizado")
	botoes_travados = false
	$MenuCreditos.visible = false
	$MenuPrincipal.visible = true


func _on_BotaoCreditos_pressed():
	if _travar_botoes():
		return
	$Fade.reproduzir_animacao()
	yield($Fade, "fade_in_finalizado")
	botoes_travados = false
	$MenuCreditos.visible = true
	$MenuPrincipal.visible = false

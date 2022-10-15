extends ColorRect


func _on_MaquinaFotogrfica_foto_tirada(_imagem, _objetos):
	$AnimationPlayer.play("flash")

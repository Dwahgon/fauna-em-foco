extends Polygon2D


func definir_imagem(img_path: String):
	var img = Image.new()
	img.load(img_path)
	
	var largura_polaroid = img.get_width()+10
	var altura_polaroid = img.get_height()+40
	
	polygon[1] = Vector2(largura_polaroid,0)
	polygon[2] = Vector2(largura_polaroid, altura_polaroid)
	polygon[3] = Vector2(0, altura_polaroid)
	
	var imagem_textura = ImageTexture.new()
	imagem_textura.create_from_image(img)
	$Sprite.texture = imagem_textura


func animar_aparecendo():
	$AnimationPlayer.play("tocar")


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()

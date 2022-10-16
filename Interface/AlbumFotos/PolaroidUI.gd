extends Panel

func definir_imagem(caminho_imagem: String):
	var img = Image.new()
	img.load(caminho_imagem)
	
	var imagem_textura = ImageTexture.new()
	imagem_textura.create_from_image(img)
	$MarginContainer/TextureRect.texture = imagem_textura

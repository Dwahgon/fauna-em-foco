extends Node2D

export(int) var id_animal: int = 0

func _ready():
	print()
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load("res://Assets/Sprites/"+Globais.dados_animais[str(id_animal)]["nome"]+".png")
	texture.create_from_image(image)
	$Sprite.texture = texture



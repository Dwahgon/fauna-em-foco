extends Node2D

export(int) var id_animal: int = 0

func _ready():
	var texture: StreamTexture = load("res://Assets/Sprites/"+Globais.dados_animais[str(id_animal)]["nome"]+".png")
	$Sprite.texture = texture



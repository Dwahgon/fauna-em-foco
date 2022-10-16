extends Node2D

export(int) var id_animal: int = 0
var tempo_desaparecer: float = 0

var _desaparecer = false

func _ready():
	var texture: StreamTexture = load("res://Assets/Sprites/"+Globais.dados_animais[str(id_animal)]["nome"]+".png")
	$Sprite.texture = texture
	modulate = Color.transparent


func animar_aparecendo():
	$AnimationPlayer.play("aparecendo")


func animar_desaparecendo():
	$AnimationPlayer.play_backwards("aparecendo")


func _on_Timer_timeout():
	animar_desaparecendo()
	_desaparecer = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "aparecendo":
		if not _desaparecer:
			$AnimationPlayer.play("idle")
			$Timer.start(tempo_desaparecer)
		else:
			queue_free()

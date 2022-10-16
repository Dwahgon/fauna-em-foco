extends Panel

signal fade_in_finalizado



func reproduzir_animacao():
	$AnimationPlayer.play("fade_in")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		print("Fade in finalizado")
		emit_signal("fade_in_finalizado")
		$AnimationPlayer.play("fade_out")

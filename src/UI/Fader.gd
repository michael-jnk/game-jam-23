extends AnimationPlayer


func fade():
	play("fade_to_black")
	

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		play("fade_to_normal")

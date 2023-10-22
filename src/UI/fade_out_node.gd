extends Node2D

signal animation_done

@onready var player = $AnimationPlayer

func _on_animation_player_animation_finished(anim_name):
	animation_done.emit()

func play():
	visible = true
	player.play("fade_in")
	
	

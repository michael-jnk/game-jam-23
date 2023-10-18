extends Node2D

signal animation_done



func _on_animation_player_animation_finished(anim_name):
	animation_done.emit()

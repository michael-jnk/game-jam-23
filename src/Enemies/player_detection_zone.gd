extends Area2D

var player = null

func player_is_detected():
	return player != null
	


func _on_area_entered(area):
	print("detected!")
	player = area



func _on_area_exited(area):
	player = null

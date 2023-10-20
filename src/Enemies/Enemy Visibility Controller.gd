extends Node2D

var player = null
var inSight = false
var alpha = 0

const fadeInSpeed = 0.1
const fadeOutSpeed = 0.01

func _physics_process(delta):
	if player == null:
		if alpha > 0:
			alpha -= fadeOutSpeed
	else:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position,9)
		var raycast = space_state.intersect_ray(query)
		if raycast.is_empty():
			if alpha < 1:
				alpha += fadeInSpeed
		else:
			if alpha > 0:
				alpha -= fadeOutSpeed

func getAlpha():
	return max(0, min(1, alpha))
	

func _on_area_2d_area_entered(area):
	player = area


func _on_area_2d_area_exited(area):
	player = null

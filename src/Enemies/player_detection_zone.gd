extends Area2D

var player = null
@onready var timer = $Timer

const lastSeenTime = 0.5
#how much time should the enemy still chase aftre losing sight of player

func player_is_detected():
	if player != null:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position,9)
		var raycast = space_state.intersect_ray(query)
		if raycast.is_empty():
			timer.start(lastSeenTime)
			timer.stop()
			return true
		elif timer.is_stopped():
			timer.start()
			return true
		else:
			return timer.time_left > 0
	return false
	


func _on_area_entered(area):
	player = area
	timer.stop()

func _on_area_exited(area):
	player = null

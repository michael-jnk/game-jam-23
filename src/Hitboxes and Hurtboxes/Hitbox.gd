extends Area2D

@export var damage = 1
@export var knockback_strength = 100
var knockback_vector = Vector2.ZERO

func get_knockback():
	return knockback_vector * knockback_strength

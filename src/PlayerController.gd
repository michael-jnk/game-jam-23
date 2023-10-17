extends Node


@export var invincibilityTime = 0.7
@export var max_health = 5
@export var damage = 5
@export var invincibilityDuration = 5
var health = 5

@onready var player1 = $"../World 1/YSortNode/Player"
@onready var player2 = $"../World 2/YSortNode/Player"


signal health_changed

func _on_player_player_hit():
	player1.create_hit_effect()
	player2.create_hit_effect()
	health -= 1
	emit_signal("health_changed", health)
	player1.start_invincibility(invincibilityDuration)
	player2.start_invincibility(invincibilityDuration)
	if health <= 0:
		if player1 != null:
			player1.queue_free()
		if player2 != null:
			player2.queue_free()
		get_tree().change_scene_to_file("res://death_scene.tscn")

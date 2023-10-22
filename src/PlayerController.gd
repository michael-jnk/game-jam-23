extends Node


@export var invincibilityTime = 0.7
@export var max_health = 5
@export var damage = 5
@export var invincibilityDuration = .5
var health = 5

@onready var player1 = $"../World 1/YSortNode/Player"
@onready var player2 = $"../World 2/YSortNode/Player"

@onready var playerTranslation = player2.global_position - player1.global_position

var PlayerDeathEffect = preload("res://Effects/player_death_effect.tscn")

enum {
	WORLD1,
	WORLD2
}

@onready var currentWorld
@onready var dashCooldown = $"../CanvasLayer/DashColdown"
@onready var fadeOutNode = $"../CanvasLayer/FadeOutNode"

signal health_changed
signal game_ended

func _physics_process(delta):
	if player1 == null:
		return
	if currentWorld == WORLD1:
		player2.global_position = player1.global_position + playerTranslation
	else:
		player1.global_position = player2.global_position - playerTranslation
	
	if player1.state != 2 && player2.state == 3:
		player2.state = 0
	elif player2.state != 2 && player1.state == 3:
		player1.state = 0

func _on_player_player_hit(world, damage):
	player1.create_hit_effect()
	player2.create_hit_effect()
	health -= damage
	emit_signal("health_changed", health)
	player1.start_invincibility(invincibilityDuration)
	player2.start_invincibility(invincibilityDuration)
	var player_death_effect1 = PlayerDeathEffect.instantiate()
	var player_death_effect2 = PlayerDeathEffect.instantiate()
	get_parent().add_child(player_death_effect1)
	get_parent().add_child(player_death_effect2)
	player_death_effect1.global_position = player1.global_position
	player_death_effect2.global_position = player2.global_position
	if health <= 0:
		if player1 != null:
			player1.queue_free()
		if player2 != null:
			player2.queue_free()
		game_ended.emit()
		


func restore_health(health_restored):
	health = min(max_health, health + health_restored)
	health_changed.emit(health)

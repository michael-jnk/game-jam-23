extends Area2D

var HitEffect = preload("res://Effects/hit_effect.tscn")

@onready var timer = $Timer
@onready var collisionShape = $CollisionShape2D
var invincible = false

signal invincibility_started
signal invincibility_ended


func _ready():
	self.invincibility_started.connect(_on_invincibility_started)
	self.invincibility_ended.connect(_on_invincibility_ended)

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
	
func start_invincibility(duration):
	self.set_invincible(true)
	timer.start(duration)
	
func create_hit_effect():
	var hit_effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(hit_effect)
	hit_effect.global_position = global_position




func _on_timer_timeout():
	self.set_invincible(false)


func _on_invincibility_ended():
	print("invincibility ended!")
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)
	collisionShape.disabled = false

func _on_invincibility_started():
	print("invincibility started!")
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	collisionShape.disabled = true



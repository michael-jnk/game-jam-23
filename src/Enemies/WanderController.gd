extends Node2D

@export var wander_range = 50

@onready var start_position = global_position
@onready var target_position = global_position

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	update_target_position()
	set_wander_timer(3)

func update_target_position():
	var target_vector = Vector2(randf_range(-wander_range, wander_range), randf_range(-wander_range, wander_range))
	target_position = start_position + target_vector
	

func get_time_left():
	if timer.time_left <= .15:
		update_target_position()
	return timer.time_left

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	

func set_wander_timer(duration):
	timer.start(duration)
	

func _on_timer_timeout():
	update_target_position()

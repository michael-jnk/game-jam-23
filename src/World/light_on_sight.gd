extends Node2D

var player = null
@onready var light = $PointLight2D
@onready var hitbox = $Area2D

var lightOn = false
const changeSpeed = 0.05
const MAX_ENERGY = 0.7

# Called when the node enters the scene tree for the first time.
func _ready():
	light.enabled = false
	lightOn = false
	light.energy = MAX_ENERGY
	light.enabled = true


func _physics_process(delta):
	if player != null:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position,9)
		var raycast = space_state.intersect_ray(query)
		if raycast.is_empty():
			light.enabled = true
			lightOn = true
		else:
			lightOn = false
	if (lightOn && light.energy <= MAX_ENERGY):
		light.energy += changeSpeed
	elif !lightOn:
		lightOn = false
		if light.energy >= 0:
			light.energy -= changeSpeed
		else:
			light.enabled = false


func _on_area_2d_area_entered(area):
	if player == null:
		player = area


func _on_area_2d_area_exited(area):
	if player != null:
		player = null
		lightOn = false

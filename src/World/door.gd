extends Node2D

@onready var animTree = $AnimationTree
const MAX_DIST = 37

var player = null


func _ready():
	animTree.set("parameters/blend_position", 10)

func _physics_process(delta):
	if player != null:
		animTree.set("parameters/blend_position", global_position.distance_to(player.global_position)/MAX_DIST)

func _on_area_2d_area_entered(area):
	player = area


func _on_area_2d_area_exited(area):
	animTree.set("parameters/blend_position", 10)
	player = null
	

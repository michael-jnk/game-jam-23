extends Area2D

@onready var world = $/root/World
const premonitionScene = preload("res://Effects/premonition_particles.tscn")
var premonitionActive = false
var premonition = null

var target = null

@onready var visibilityController = $"../Enemy Visibility Controller"

const MAX_ENERGY = 0.41 
# dont forget to change this when you change the particle light energy!!

func create_premonition(targ):
	target = targ
	premonition = premonitionScene.instantiate()
#	print("World "+str((targ.world%2)+1)+"/YSortNode/Player")
	world.get_node("World "+str((targ.world%2)+1)+"/YSortNode/Player").add_child(premonition)
	premonition.position = global_position - target.global_position
	premonitionActive = true

func remove_premonition():
	premonitionActive = false
	if premonition != null:
		premonition.queue_free()
	target = null

func _physics_process(delta):
	if premonitionActive:
		premonition.position = global_position - target.global_position
		premonition.modulate.a = visibilityController.getAlpha()
		premonition.get_node("PointLight2D").energy = MAX_ENERGY * visibilityController.getAlpha()

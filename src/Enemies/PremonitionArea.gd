extends Area2D

@onready var world = $/root/World
const premonitionScene = preload("res://Effects/premonition_particles.tscn")
var premonitionActive = false
var premonition = null

var target = null

func create_premonition(targ):
	target = targ
	premonition = premonitionScene.instantiate()
#	print("World "+str((targ.world%2)+1)+"/YSortNode/Player")
	world.get_node("World "+str((targ.world%2)+1)+"/YSortNode/Player").add_child(premonition)
	premonition.position = global_position - target.global_position
	premonitionActive = true

func remove_premonition():
	premonitionActive = false
	premonition.queue_free()
	target = null

func _physics_process(delta):
	if premonitionActive:
		premonition.position = global_position - target.global_position

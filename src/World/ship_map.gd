extends Node2D


@onready var flooring = $Flooring
# Called when the node enters the scene tree for the first time

func world(isWorld1):
	if isWorld1:
		flooring.material.set_shader_parameter("is_past", true)
	else:
		flooring.material.set_shader_parameter("is_past", false)
	

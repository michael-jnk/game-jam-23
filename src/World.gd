extends Node2D

@onready var camera1 = $"World 1/YSortNode/Camera2D"
@onready var camera2 = $"World 2/YSortNode/Camera2D"


enum {
	WORLD1,
	WORLD2
}

var currentWorld = WORLD2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change_position"):
		if currentWorld == WORLD1:
			camera1.enabled = false
			camera2.enabled = true
			currentWorld = WORLD2
		else:
			camera2.enabled = false
			camera1.enabled = true
			currentWorld = WORLD1

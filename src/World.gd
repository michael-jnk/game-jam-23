extends Node2D

@onready var camera1 = $"World 1/YSortNode/Camera2D"
@onready var camera2 = $"World 2/YSortNode/Camera2D"
@onready var fader = $CanvasLayer/Fader
@onready var transitionEffect = $TransitionSoundEffect

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
		fader.fade()
		transitionEffect.play()
			
			


func _on_fader_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "fade_to_black":
		print("hello!")
		if currentWorld == WORLD1:
			camera2.position_smoothing_enabled = false
			camera1.enabled = false
			camera2.enabled = true
			camera2.position_smoothing_enabled = true
			currentWorld = WORLD2
		elif currentWorld == WORLD2:
			camera1.position_smoothing_enabled = false
			camera2.enabled = false
			camera1.enabled = true
			camera2.position_smoothing_enabled = true
			currentWorld = WORLD1
		

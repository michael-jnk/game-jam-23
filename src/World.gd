extends Node2D

@onready var camera1 = $"World 1/YSortNode/Camera2D"
@onready var camera2 = $"World 2/YSortNode/Camera2D"
@onready var fader = $CanvasLayer/Fader
@onready var transitionEffect = $TransitionSoundEffect

@onready var playerController = $PlayerController
@onready var modulater = $CanvasModulate

var enemies_killed = 0 
const enemiesKillsNeeded = 3

enum {
	WORLD1,
	WORLD2
}


var currentWorld = WORLD2
# Called when the node enters the scene tree for the first time.
func _ready():
	playerController.currentWorld = currentWorld
	playerController.player1.onWorld = currentWorld == WORLD1
	playerController.player2.onWorld = currentWorld == WORLD2

			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change_position"):
		playerController.currentWorld = currentWorld
		playerController.player1.onWorld = !playerController.player1.onWorld
		playerController.player2.onWorld = !playerController.player2.onWorld
		fader.fade()
		transitionEffect.play()
			
			


func _on_fader_animation_finished(anim_name):
#	print(anim_name)
	if anim_name == "fade_to_black":
#		print("hello!")
		if currentWorld == WORLD1:
			modulater.visible = false
			camera2.position_smoothing_enabled = false
			camera1.enabled = false
			camera2.enabled = true
			camera2.position_smoothing_enabled = true
			currentWorld = WORLD2
			playerController.currentWorld = WORLD2
		elif currentWorld == WORLD2:
			modulater.visible = true
			camera1.position_smoothing_enabled = false
			camera2.enabled = false
			camera1.enabled = true
			camera2.position_smoothing_enabled = true
			currentWorld = WORLD1
			playerController.currentWorld = WORLD1
		

func enemy_died(isWorld1):
	enemies_killed += 1
	if enemies_killed >= enemiesKillsNeeded:
		print("Done!")

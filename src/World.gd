extends Node2D

@onready var camera1 = $"World 1/YSortNode/Camera2D"
@onready var camera2 = $"World 2/YSortNode/Camera2D"
@onready var fader = $CanvasLayer/Fader
@onready var transitionEffect = $TransitionSoundEffect

@onready var playerController = $PlayerController
@onready var modulater = $CanvasModulate

@onready var transitionCooldownTimer = $TransitionCooldownTimer

@export var transitionCooldown = 3
@onready var coolDownController = $CanvasLayer/TransitionCooldown

var enemies_killed = 0 
var artifacts_found = 0
var transitionCooldownActive = false

@export var enemiesKillsNeeded = 10

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
	modulater.visible = currentWorld == WORLD1

			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	coolDownController.setProgValue((transitionCooldown - transitionCooldownTimer.time_left) * 100 / transitionCooldown)
	if Input.is_action_just_pressed("change_position"):
		if transitionCooldownActive:
			return
		playerController.currentWorld = currentWorld
		playerController.player1.onWorld = !playerController.player1.onWorld
		playerController.player2.onWorld = !playerController.player2.onWorld
		fader.fade()
		transitionEffect.play()
		transitionCooldownTimer.start(transitionCooldown)
		transitionCooldownActive = true
			
			


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
		get_tree().change_scene_to_file("res://enemy_ending.tscn")
	
func artifact_found():
	artifacts_found += 1
	if artifacts_found == 4:
		print("Game Won!")


func _on_transition_cooldown_timer_timeout():
	transitionCooldownActive = false

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
@onready var yearLabel = $CanvasLayer/YearLabel
@onready var fadeOutNode = $CanvasLayer/FadeOutNode

@onready var musicPlayer1 = $"Music Player"
@onready var musicPlayer2 = $"Music Player2"
@onready var borderEffect = $CanvasLayer/BorderEffect

const pastYear = "2020"
const presentYear = "3000"
const SILENT_DB = -80

var enemies_killed = 0 
var artifacts_found = 0
var transitionCooldownActive = false

@export var enemiesKillsNeeded = 10

enum {
	WORLD1,
	WORLD2
}


enum {
	PLAYER_DEATH,
	ARTIFACT,
	ENEMY
}

var game_end_condition = null

var currentWorld = WORLD2
# Called when the node enters the scene tree for the first time.
func _ready():
	playerController.currentWorld = currentWorld
	playerController.player1.onWorld = currentWorld == WORLD1
	playerController.player2.onWorld = currentWorld == WORLD2
	modulater.visible = currentWorld == WORLD1
	yearLabel.text = presentYear
	fadeOutNode.visible = false
	borderEffect.visible = false

			

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
			borderEffect.visible = false
			yearLabel.text = presentYear
			modulater.visible = false
			camera2.position_smoothing_enabled = false
			camera1.enabled = false
			camera2.enabled = true
#			musicPlayer1.volume_db = SILENT_DB
#			musicPlayer2.volume_db = 0
			musicPlayer1.pitch_scale = 1
			camera2.position_smoothing_enabled = true
			currentWorld = WORLD2
			playerController.currentWorld = WORLD2
		elif currentWorld == WORLD2:
			borderEffect.visible = true
			yearLabel.text = pastYear
			modulater.visible = true
			camera1.position_smoothing_enabled = false
			camera2.enabled = false
			camera1.enabled = true
#			musicPlayer2.volume_db = SILENT_DB
#			musicPlayer1.volume_db = 0
			musicPlayer1.pitch_scale = .7
			camera2.position_smoothing_enabled = true
			currentWorld = WORLD1
			playerController.currentWorld = WORLD1
		

func enemy_died(isWorld1):
	enemies_killed += 1
	if enemies_killed >= enemiesKillsNeeded:
		game_end_condition = ENEMY
		end_game()
		


func _on_artifact_controller_artifact_condition_met():
	game_end_condition = ARTIFACT
	end_game()
	


func _on_player_controller_game_ended():
	game_end_condition = PLAYER_DEATH
	end_game()
	


func _on_transition_cooldown_timer_timeout():
	transitionCooldownActive = false


	

func end_game():
	fadeOutNode.visible = true
	fadeOutNode.play()
	


func _on_fade_out_node_animation_done():
	match game_end_condition:
		ENEMY:
			get_tree().change_scene_to_file("res://enemy_ending.tscn")
		ARTIFACT:
			get_tree().change_scene_to_file("res://artifact_ending.tscn")
		PLAYER_DEATH:
			get_tree().change_scene_to_file("res://death_scene.tscn")

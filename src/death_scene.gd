extends Control


@onready var timer = $Timer
var isReadyToReset = false
@onready var tryAgainLabel = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	tryAgainLabel.visible = false
	timer.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isReadyToReset:
		return
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://StartScreen.tscn")


func _on_timer_timeout():
	isReadyToReset = true
	tryAgainLabel.visible = true
	
	
	

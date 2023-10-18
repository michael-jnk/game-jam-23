extends Control


@onready var progressVar = $ProgressBar
@onready var timer = $Timer
@export var DASH_COOLDOWN_TIME = 0.7
# Called when the node enters the scene tree for the first time.
func _process(delta):
	progressVar.value = (DASH_COOLDOWN_TIME - timer.time_left) * 100/ DASH_COOLDOWN_TIME

func start_dash():
	timer.start(DASH_COOLDOWN_TIME)
	progressVar.value = 0


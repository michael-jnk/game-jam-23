extends Control

var hearts = 4
var max_hearts = 4

signal no_health

@onready var playerController = $"../../PlayerController"
@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty
@onready var heartUIHalf = $HeartUIHalf

func _ready():
	print(playerController.max_health)
	self.set_max_hearts(playerController.max_health) 
	self.set_hearts(playerController.health)
	playerController.health_changed.connect(set_hearts)
	heartUIFull.visible = true



func set_max_hearts(value):
	max_hearts = max(value, 1)
	if heartUIEmpty != null:
		heartUIEmpty.size.x = max_hearts * 15
	
	

func set_hearts(value):
	hearts = clamp(0, value, max_hearts)	
	if heartUIFull != null:
		if hearts >= 1:
			heartUIFull.size.x = int(hearts) * 15
		else:
			heartUIFull.visible = false
		if int(hearts) != hearts:	
			heartUIHalf.size.x = (int(hearts) + 1) * 15
		else:
			heartUIHalf.size.x = hearts * 15
	print(hearts)
	

# Called when the node enters the scene tree for the first time.





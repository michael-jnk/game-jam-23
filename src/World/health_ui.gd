extends Control

var hearts = 4
var max_hearts = 4

signal no_health
signal health_changed(value)

@onready var player = $"../../YSortNode/Player"
@onready var heartUIFull = $HeartUIFull
@onready var heartUIEmpty = $HeartUIEmpty

func _ready():
	print(player.max_health)
	self.set_max_hearts(player.max_health) 
	self.set_hearts(player.health)
	player.health_changed.connect(set_hearts)



func set_max_hearts(value):
	max_hearts = max(value, 1)
	if heartUIEmpty != null:
		heartUIEmpty.size.x = max_hearts * 15
	
	

func set_hearts(value):
	hearts = clamp(0, value, max_hearts)	
	emit_signal("health_changed")
	if heartUIFull != null:
		
		heartUIFull.size.x = hearts * 15
	

# Called when the node enters the scene tree for the first time.





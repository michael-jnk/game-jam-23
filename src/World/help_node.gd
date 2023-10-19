extends Node2D

@export var helpNumber = 0

@onready var helpController = $"../../../../CanvasLayer/HelpController"
var isExhausted = false
signal help_required(helpNumber)

# Called when the node enters the scene tree for the first time.
func _ready():
	help_required.connect(helpController._on_help_node_help_required)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	print("collided!")
	help_required.emit(helpNumber)
	queue_free()

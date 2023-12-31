extends Node2D

@export var artifactNumber = 0

signal artifact_found(artifactNumber)


@onready var artifactController = $"../../../../CanvasLayer/NoteController"
@onready var root = $"../../../.."

func _on_hurtbox_area_entered(area):
	artifact_found.emit(artifactNumber)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	artifact_found.connect(artifactController.artifact_found)
	artifact_found.connect(artifactController.artifact_found)


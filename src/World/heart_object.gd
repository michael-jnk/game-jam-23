extends Node2D

@export var health_restoration = 3

@onready var playerController = $"../../../../PlayerController"

signal health_restored(number_of_hearts)


@onready var artifactController = $"../../../../CanvasLayer/ArtifactController"
@onready var root = $"../../../.."

func _on_hurtbox_area_entered(area):
	health_restored.emit(health_restoration)
	queue_free()

func _ready():
	health_restored.connect(playerController.restore_health)



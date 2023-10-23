extends Node2D

@export var health_restoration = 3

@onready var playerController = $"../../../../PlayerController"

signal health_restored(number_of_hearts)


@onready var artifactController = $"../../../../CanvasLayer/ArtifactController"
@onready var root = $"../../../.."

var MAX_LIGHT_ENERGY
@onready var visibilityController = $"Enemy Visibility Controller"
@onready var light = $PointLight2D2

func _on_hurtbox_area_entered(area):
	health_restored.emit(health_restoration)
	queue_free()

func _ready():
	health_restored.connect(playerController.restore_health)
	MAX_LIGHT_ENERGY = light.energy

func _physics_process(delta):
	modulate.a = visibilityController.getAlpha()
	light.energy = MAX_LIGHT_ENERGY * visibilityController.getAlpha()
	

extends Node2D

@onready var animatedSprite = $AnimatedSprite2D

var flip_h = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite.frame = 0
	animatedSprite.play()
	animatedSprite.flip_h = flip_h

	
func _on_animated_sprite_2d_animation_finished():
	queue_free()

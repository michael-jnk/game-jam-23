extends StaticBody2D

@onready var visibilityControl = $"Enemy Visibility Controller"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate.a = visibilityControl.getAlpha()

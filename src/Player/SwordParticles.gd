extends CPUParticles2D

func _ready():
	emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !emitting:
		queue_free()

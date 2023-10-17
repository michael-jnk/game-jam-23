extends Sprite2D

const DURATION = 0.15
var dur = DURATION

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dur -= delta
	if dur <= 0:
		queue_free()

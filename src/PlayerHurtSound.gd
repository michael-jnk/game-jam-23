extends AudioStreamPlayer


func _ready():
	self.connect("finished", queue_free)

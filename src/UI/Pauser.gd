extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	
	
var isPaused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !isPaused
		isPaused = !isPaused
		self.visible = !visible
		

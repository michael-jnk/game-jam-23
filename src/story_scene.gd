extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var current_slide = 0
var story = ["adsfkjhlasd flkjhasdlkfjhasldkjfha lsdkjfhalsdkjfh askdljfhalskjdfhaklsjdf hasdf", "asdflkja sdlkfja;skdlfja ;lsdkfj"]

@onready var label = $TextBox/RichTextLabel
@onready var doneMark = $"TextBox/Done Label"
@onready var clickPlayer1 = $AudioStreamPlayer1
@onready var clickPlayer2 = $AudioStreamPlayer2

var click = false
var current_story_rendered = ""
var current_story_index = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_story_index < len(story[current_slide]):
		label.append_text(story[current_slide][current_story_index])
		current_story_index += 1
		if click:
			clickPlayer1.play()
		else:
			clickPlayer2.play()
		click = not click
	else:
		doneMark.text = "⌄"
	
	if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("attack"):
		label.clear()
		current_story_index = 0
		current_slide += 1
		doneMark.text = ""
		
		if current_slide == len(story):
			get_tree().change_scene_to_file("res://World.tscn")
		
#func render_text(s):
#	label.
	
		


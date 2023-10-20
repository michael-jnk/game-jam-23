extends Control


# Called when the node enters the scene tree for the first time.
@onready var label = $RichTextLabel
@onready var doneMark = $"Done Label"
@onready var clickPlayer1 = $AudioStreamPlayer1
@onready var clickPlayer2 = $AudioStreamPlayer2

var click = false
var current_story_rendered = ""
var current_story_index = 0
var current_slide = 0

var shiftUp = false

var isReady = false
@onready var animationPlayer = $AnimationPlayer
var slowBool = true
var story = null

signal story_done
signal slide_reached(slideNumber)



func render_story(renderedStory):
	label.clear()
	story = renderedStory
	current_story_index = 0
	current_slide = 0
	
	isReady = true
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isReady:
		return
	if current_story_index < len(story[current_slide]):
		slowBool = !slowBool
		if slowBool:
			return
		label.append_text(story[current_slide][current_story_index])
		current_story_index += 1
		if click:
			clickPlayer1.play()
		else:
			clickPlayer2.play()
		click = not click
	else:
		doneMark.text = "⌄"
		
	
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("ui_accept"):
		label.clear()
		current_story_index = 0
		current_slide += 1
		doneMark.text = ""
		emit_signal("slide_reached", current_slide)
		
	if current_slide == len(story):
		emit_signal("story_done")
		current_story_index = 0
		current_slide = 0
		isReady = false

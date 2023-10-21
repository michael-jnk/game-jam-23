extends Control



var current_slide = 0
var story = ["After 40 long years, the truth is finally revealed."]



var click = false
var current_story_rendered = ""
var current_story_index = 0

@onready var textBox = $TextBox

var shiftUp = false

var isReady = false
@onready var animationPlayer = $AnimationPlayer
var slowBool = true

	


func _on_timer_timeout():
	shiftUp = !shiftUp
	


func _on_auto_fade_node_animation_done():
	isReady = true
	textBox.render_story(story)


func _on_text_box_slide_reached(slideNumber):
	print(slideNumber)
	


func _on_text_box_story_done():
	get_tree().change_scene_to_file("res://StartScreen.tscn")

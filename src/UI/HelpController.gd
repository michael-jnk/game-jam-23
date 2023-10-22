extends Node



@onready var textbox = $"../HelpTextBox"

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

const help_messages = [["Welcome to the STAR47."], ["Press Shift to dash and Space to attack."], ["You will encounter enemies across this journey."],["Press E to change the year and access the enemies the enemies with the red glow."]]


func _on_help_node_help_required(helpNumber):
	textbox.visible = true
	textbox.render_story(help_messages[helpNumber])
	


func _on_help_text_box_story_done():
	textbox.visible = false

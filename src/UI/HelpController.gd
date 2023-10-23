extends Node



@onready var textbox = $"../HelpTextBox"

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

const help_messages = [["Welcome aboard the STAR47. Press Enter or Space to dismiss this message."], 
["Press Shift to dash and Space to attack."],
["Attack enemies with your sword to kill them."],
["Press E to transport yourself to the past and access the enemies with the red glow."],
["Continue collecting artifacts and notes of the crew to discover the truth."]]


func _on_help_node_help_required(helpNumber):
	textbox.visible = true
	textbox.render_story(help_messages[helpNumber])
	


func _on_help_text_box_story_done():
	textbox.visible = false

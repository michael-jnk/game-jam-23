extends Control



var current_slide = 0
var story = ["The year is 3089.",
 "It has been 107 years since the nineteen crew members of mission Aeternitas 1 left Earth.",
 "They set out to establish a colony on planet X45t-9 after it was discovered to be able to support human life.",
"ASAN (Administration Space Aeronautics National) had led efforts in searching for planets that could support human life for decades,",
"but the search became more drastic after startling projections revealed the sun was rapidly approaching its death.",
"With a definitive date for the extinction of humanity set 300 years in the future, ASAN's specialists searched and searched for life-supporting planets.",
"Nine long years later, planet X45t-9 of the Triangulum Galaxy was discovered to meet all conditions necessary to support human life.",
"Immediately following the discovery, ASAN assembled a nineteen-person crew to make the journey across space and time to X45t-9 and establish a colony.",
"Hearts filled with hope and promise, the members of Aeternitas 1 boarded the STAR47, where they would spend the next 4 years of their lives in cryosleep while traveling to X45t-9.",
"However, after a series of mysterious and unforeseen events, ASAN lost contact with STAR47 2 years into the expedition.",
"ASAN spent years trying to regain contact with the crew, but to no avail.",
"It seemed that all hope was lost.",
"Suddenly, after 107 years, ASAN began receiving distress signals from STAR47.",
"ASAN knew that this might be their only chance to understand what happened to the crew of Aeternitas 1 and establish a colony on X45t-9",
"so it sent one of its best astronauts, 63-B, armed with a revolutionary new technology on a mission to board STAR47 and uncover the truth...",
"...before it's too late."
]




var click = false
var current_story_rendered = ""
var current_story_index = 0

@onready var textBox = $TextBox

var shiftUp = false

var isReady = false
@onready var background_sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer
var slowBool = true

func _ready():
	textBox.set_height(100)	


func _on_timer_timeout():
	shiftUp = !shiftUp
	


func _on_auto_fade_node_animation_done():
	isReady = true
	textBox.render_story(story)


func _on_text_box_slide_reached(slideNumber):
	if slideNumber <= 15:
		background_sprite.frame = slideNumber
	


func _on_text_box_story_done():
	get_tree().change_scene_to_file("res://World.tscn")

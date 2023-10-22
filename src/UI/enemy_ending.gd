extends Control




@onready var animationPlayer = $AnimationPlayer
@onready var sprite2 = $Sprite2D2
@onready var textBox = $TextBox
@onready var fade_out_node=  $FadeOutNode

var firstAnimation = false

func _ready():
	sprite2.visible = false
	


func _on_auto_fade_node_animation_done():
	animationPlayer.play("ship_zoom_in")

	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ship_zoom_in":
		sprite2.visible = true
		animationPlayer.play("ship_zoom_out")
	else:
		fade_out_node.play()
		


func _on_fade_out_node_animation_done():
	get_tree().change_scene_to_file("res://StartScreen.tscn")

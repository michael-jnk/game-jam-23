extends Node


var artifacts_found = 0
@onready var artifactUI = $"../ArtifactUI"
@onready var artifactTextBox = $"../ArtifactTextBox"

signal artifact_condition_met


const artifact_texts = [["A book from the past. It is titled \" Why I killed your mother\". It has \"Help me\" written on the front."],
 ["asdlkfj;as;ldkfja;lskdfj"], 
["asdlf;kjasd;lfjk"],
["asdfl;kjasdf;lkjadsfa"]]

func _ready():
	artifactTextBox.visible = false

func artifact_found(artifactNumber):
	artifacts_found += 1
	artifactUI.display_artifact(artifactNumber)
	artifactTextBox.visible = true
	artifactTextBox.render_story(artifact_texts[artifactNumber])
	if artifacts_found == 4:
		artifact_condition_met.emit()
		


func _on_artifact_text_box_story_done():
	artifactTextBox.visible = false

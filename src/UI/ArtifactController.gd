extends Node


var artifacts_found = 0
@onready var artifactUI = $"../ArtifactUI"
@onready var artifactTextBox = $"../ArtifactTextBox"

const artifact_texts = [["ASDFKLASDJFLKAJSFd"], ["asdlkfj;as;ldkfja;lskdfj"], ["asdlf;kjasd;lfjk"]]

func _ready():
	artifactTextBox.visible = false

func artifact_found(artifactNumber):
	artifacts_found += 1
	artifactUI.display_artifact(artifactNumber)
	artifactTextBox.visible = true
	artifactTextBox.render_story(artifact_texts[artifactNumber])


func _on_artifact_text_box_story_done():
	artifactTextBox.visible = false

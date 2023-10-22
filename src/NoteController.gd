extends Node


var artifacts_found = 0
@onready var artifactUI = $"../NoteUI"
@onready var artifactTextBox = $"../ArtifactTextBox"

signal artifact_condition_met


const artifact_texts = [["This book belonged to Pilot 93-D, a capable and kind navigator on the Aeternitas 1 crew.",
"Unassuming to those who didn’t know them, 93-D was actually a great chef and an avid bookworm.",
 "This specific book, called Nol Skrulgad and the Seven Swords,", "was the 4th installment of the Auvrul Chronicles series, an all time favorite of theirs."],
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
	if artifacts_found == 5:
		artifact_condition_met.emit()
		


func _on_artifact_text_box_story_done():
	artifactTextBox.visible = false

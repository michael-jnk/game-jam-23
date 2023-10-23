extends Node


var artifacts_found = 0
@onready var artifactUI = $"../ArtifactUI"
@onready var artifactTextBox = $"../ArtifactTextBox"

signal artifact_condition_met


const artifact_texts = [

# artifact 1	
["This book belonged to Pilot 93-D, a capable and kind navigator on the Aeternitas 1 crew.",
"Unassuming to those who didn’t know them, 93-D was actually a great chef and an avid bookworm.",
 "This specific book, called Nol Skrulgad and the Seven Swords,",
 "was the 4th installment of the Auvrul Chronicles series, an all time favorite of theirs.",
"It is odd that it is laying around in the entranceway."],

#artifact 2
 ["This necklace belonged to Mission Specialist 872-L,",
 "a methodical classically trained pianist turned aeronautical scientist.",
 "It was a family heirloom passed down in their family for generations,",
 "and said to bring good fortune, having been originally purchased by an ancestor from the Silk Road in 140 BCE.",
 "It is inlaid with garnets and rubies and would fetch an astronomically high price if sold."],

# artifact 3 
["This Skibur Cube belonged to Commander 34-A who was the leader of Aeternitas 1.",
 "Back in their heyday, they were a 5-time speedcubing world champion.",
 "Praised as a courageous and charismatic leader,",
 "Commander 34-A was dearly missed by family and friends and the ASAN community on Earth"],

# artifact 4
["This key belonged to Flight Engineer 339-T,",
 "known for their invention of the Robotized Warfare Manipulsator Matrix",
 "and Adaptable Probe Transferator Device.",
 "She was rumored to open their secret vault in the Swiss Alps with all of their less savory technologies.",
 "As an astronaut, 339-T was the most sociable and amiable of the crew,",
 "and enjoyed watching reality TV shows in their free time."]]

func _ready():
	artifactTextBox.visible = false

func artifact_found(artifactNumber):
	artifacts_found += 1
	artifactUI.display_artifact(artifactNumber)
	artifactTextBox.visible = true
	artifactTextBox.render_story(artifact_texts[artifactNumber])
	get_tree().paused = true
	if artifacts_found == 4:
		artifact_condition_met.emit()
		
		


func _on_artifact_text_box_story_done():
	get_tree().paused = false
	artifactTextBox.visible = false

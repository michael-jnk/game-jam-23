extends Control

@onready var artifact1 = $HSplitContainer/Artifact1
@onready var artifact2 = $HSplitContainer/HSplitContainer/Artifact2
@onready var artifact3 = $HSplitContainer/HSplitContainer/HSplitContainer2/Artifact3
@onready var artifact4 = $HSplitContainer/HSplitContainer/HSplitContainer2/Artifact4

# Called when the node enters the scene tree for the first time.
func _ready():
	artifact1.visible = false
	artifact2.visible = false
	artifact3.visible = false
	artifact4.visible = false


func display_artifact(artifactNum):
	print("Artifact displayed!")
	match artifactNum:
		0:
			artifact1.visible = true
		1:
			artifact2.visible = true
		2:
			artifact3.visible = true
		3:
			artifact4.visible = true

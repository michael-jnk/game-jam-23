extends Control

@onready var artifact1 = $HSplitContainer/Artifact1
@onready var artifact2 = $HSplitContainer/HSplitContainer/Artifact2
@onready var artifact3 = $HSplitContainer/HSplitContainer/HSplitContainer2/Artifact3
@onready var artifact4 = $HSplitContainer/HSplitContainer/HSplitContainer2/HSplitContainer3/Artifact4
@onready var artifact5 = $HSplitContainer/HSplitContainer/HSplitContainer2/HSplitContainer3/Artifact5

# Called when the node enters the scene tree for the first time.
func _ready():
	artifact1.visible = false
	artifact2.visible = false
	artifact3.visible = false
	artifact4.visible = false
	artifact5.visible = false


func display_artifact(artifactNum):
	print("Note made!")
	match artifactNum:
		0:
			artifact1.visible = true
		1:
			artifact2.visible = true
		2:
			artifact3.visible = true
		3:
			artifact4.visible = true
		4:
			artifact5.visible = true

extends Control


@onready var progressVar = $ProgressBar


func setProgValue(value):
	progressVar.value = value


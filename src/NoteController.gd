extends Node


var artifacts_found = 0
@onready var artifactUI = $"../NoteUI"
@onready var artifactTextBox = $"../ArtifactTextBox"

signal artifact_condition_met


const artifact_texts = [
	# note 1
["93-D (3 years after the mission began, year 2982, month 4)",
"Everyone was awoken from cryosleep today. Disoriented, I went to check the navigation console and we are still 6942069 miles from X45t-9.",
"872-L checked the cryosleep system regulators and nothing appeared to have malfunctioned,",
"so we are still at a loss as to why this has occurred.",
"At the current moment, we are trying to see if we can re-enter cryosleep. If we cannot, Aeternitas 1 has failed."],
# note 2
 ["93-D (3 years after the mission began, year 2982, month 4)",
"As 339-T was observing the central console, I went to do a sweep of STAR47 to ensure nothing else was awry.",
"Everything appeared to be orderly as I checked the loading bay, the storage warehouse, the greenhouse, and the simulation room,",
"but as I entered the living quarantine bay, I noticed that a few of the Atheatid containers had sustained damage.",
"They were severely cracked, with most having a large hole in them.",
"What was even more concerning was that no one else on the crew had seen any Atheatids around the ship.",
"Unsure of how to proceed, Commander 34-A ordered the crew to search the ship in order to find and requarantine the Atheatids.",
"After hours of scouring STAR47, we came up with nothing. We have no idea where they have gone.",
"872-L has tried to assure everyone that it is not such a big deal, as Atheatids are thought to be harmless biological pest controllers.",
"It's safe to say that the crew is feeling disheartened about the day's events."], 
# note 3:

["93-D (3 years after the mission began, year 2982, month 5)",
"It turns out that the cryosleep mechanism cannot be reinstated after leaving the pods.",
"It is officially impossible for us to reach our destination.",
"We also cannot establish contact with ASAN to communicate our status.",
"Commander 34-A has been trying to keep spirits high and the crew optimistic,",
"but we all know we are bound to die within the next 8 months once our foodstores run dry.",
"To make matters worse, I woke up with a strange mark on my arm.",
"It looks almost like a bite, but I decided not to visit the medic and let it heal on its own.",
"I'm sure it is just a scratch."],

#note 4:
["93-D (3 years after the mission began, year 2982, month 5)",
"I decided to visit the medic today.",
"I started having cold sweats and auditory hallucinations a few days ago, but my condition has only declined from there.",
"I have black welts all over my body and hypersensitive hearing and vision.",
"As I write this, the sound of pen against paper sounds volumes louder than it should.",
"The medic has been giving me every antibiotic, vaccine, and liquid medication in our stores,",
"but nothing has seemed to have worked.",
"I am in searing pain constantly and I don't know how much longer I can hold on."],

# note 5:
["872-L (3 years after the mission began, year 2982, month 7)",
"We are down to 3 members. Everyone else has succumbed to the illness,",
"I suspect that it is caused by Atheatid bites, and the medic had no way of treating them.",
"The illness is transmitted to humans by other humans via bodily fluids,",
"but getting the bites themselves is seemingly unavoidable.",
"We were never able to find the Athetids themselves.",
"Every week, a new member woke up with a bite, and would rapidly decline in health within 13 hours.",
"The corpses themselves are horrifying.",
"New limbs, horrible welts, new mouths and teeth - they don't even look human anymore.",
"There is only a matter of time before 34-A, 339-T, and I die as well.",
"In our last few inevitable days alive, we are trying to transmit our distress signal",
"to alert ASAN that Aeternitas 1 has gone to hell."]

]

func _ready():
	artifactTextBox.visible = false

func artifact_found(artifactNumber):
	artifacts_found += 1
	artifactUI.display_artifact(artifactNumber)
	artifactTextBox.visible = true
	artifactTextBox.render_story(artifact_texts[artifactNumber])
	get_tree().paused = true
	if artifacts_found == 5:
		artifact_condition_met.emit()
		


func _on_artifact_text_box_story_done():
	artifactTextBox.visible = false
	get_tree().paused = false

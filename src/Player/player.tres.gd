extends CharacterBody2D

@export var world: int
var onWorld: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.

var temp_velocity = Vector2.ZERO
const MAX_SPEED = 80
const ACCELLERATION = 200
const FRICTION = 70
const DASH_SPEED = MAX_SPEED * 2

@onready var hurtbox = $Hurtbox

var state = MOVE
var dash_vector = Vector2.ZERO

@export var max_health = 4
@export var health = 4




var HitEffect = preload("res://Effects/hit_effect.tscn")

enum {
	MOVE,
	DASH, 
	ATTACK,
	ATTACKINACTIVE
}

var animationPlayer = null
var animationTree = null
var animationState = null

@onready var swordHitbox = $HitboxPivot/SwordHitbox
@onready var PlayerHurtSound = preload("res://World/PlayerHurtSound.tscn")

signal health_changed
signal player_hit
signal dash_started

signal attack_started

@onready var sprite = $Sprite2D
const DASHLENGTH = 0.2 #in seconds
@export var DASH_COOLDOWN = 0.7 #in seconds
var dashLengthLeft = DASHLENGTH
var dashCooldown = 0
var evenFrame = false
var effectScene = preload("res://Effects/dash_effect.tscn")


func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
	animationTree.active = true
	swordHitbox.knockback_vector = dash_vector
	get_node("HitboxPivot/SwordHitbox/CollisionShape2D").disabled = true

func _physics_process(delta):
	match state: 
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()
		DASH:
			dash_state(delta)

		

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	dash_vector = input_vector
	swordHitbox.knockback_vector = dash_vector
	#input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELLERATION * delta)
		#velocity += input_vector * ACCELLERATION * delta
		animationState.travel("Run")
		velocity = velocity.clamp(-Vector2.ONE * MAX_SPEED, Vector2.ONE * MAX_SPEED)
		
		if dashCooldown > 0:
			dashCooldown -= delta
		elif Input.is_action_just_pressed("dash"):
			emit_signal("dash_started")
			state = DASH
			dashLengthLeft = DASHLENGTH
			evenFrame = false
			dashCooldown = DASH_COOLDOWN
	else:
		velocity =  velocity.move_toward(Vector2.ZERO, FRICTION)
		animationState.travel("Idle")
	
	if Input.is_action_just_pressed("attack"):
		if onWorld:
			state = ATTACK
		else:
			state = ATTACKINACTIVE
#			print("attackinactive")
	move_and_slide()

func attack_state():
	animationState.travel("Attack")
	velocity = Vector2.ZERO

func attack_animation_finished():
	state = MOVE

func other_attack_dont():
	state = MOVE
#func roll_state():
#	animationState.travel("Roll")
#	velocity = roll_vector * ROLL_SPEED
#
#	move_and_slide()

func dash_state(delta):
	dashLengthLeft -= delta
#	if (dashLengthLeft/DASHFRAMES) >= (dashLengthLeft/DASHLENGTH):
	if evenFrame:
		var effect = effectScene.instantiate()
		effect.frame = sprite.frame
		get_tree().current_scene.add_child(effect)
		effect.global_position = global_position
	evenFrame = !evenFrame
	
	velocity = dash_vector * DASH_SPEED
	move_and_slide()
	
	if dashLengthLeft <= 0:
		state = MOVE

func _on_hurtbox_area_entered(area):
	var playerHurtSound = PlayerHurtSound.instantiate()
	get_parent().add_child(playerHurtSound)
	emit_signal("player_hit", world)
	velocity = area.get_knockback() * 2
	
func start_invincibility(duration):
	hurtbox.start_invincibility(duration)

func create_hit_effect():
	hurtbox.create_hit_effect()


func _on_premonition_detection_zone_area_entered(area):
	area.create_premonition(self)


func _on_premonition_detection_zone_area_exited(area):
	area.remove_premonition()

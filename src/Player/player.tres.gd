extends CharacterBody2D



# Get the gravity from the project settings to be synced with RigidBody nodes.

var temp_velocity = Vector2.ZERO
const MAX_SPEED = 80
const ACCELLERATION = 200
const FRICTION = 70
const ROLL_SPEED = MAX_SPEED * 1.5

@onready var hurtbox = $Hurtbox

var state = MOVE
var roll_vector = Vector2.ZERO

@export var max_health = 4
@export var health = 4




var HitEffect = preload("res://Effects/hit_effect.tscn")

enum {
	MOVE,
	ROLL, 
	ATTACK
}

var animationPlayer = null
var animationTree = null
var animationState = null

@onready var swordHitbox = $HitboxPivot/SwordHitbox
@onready var PlayerHurtSound = preload("res://World/PlayerHurtSound.tscn")

signal health_changed

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	get_node("HitboxPivot/SwordHitbox/CollisionShape2D").disabled = true

func _physics_process(delta):
	match state: 
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()
		ROLL:
			roll_state()

		

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	roll_vector = input_vector
	swordHitbox.knockback_vector = roll_vector
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
	else:
		velocity =  velocity.move_toward(Vector2.ZERO, FRICTION)
		animationState.travel("Idle")
	if move_and_slide():
		print("collided!")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func attack_state():
	animationState.travel("Attack")
	velocity = Vector2.ZERO

func attack_animation_finished():
	state = MOVE
	
func roll_state():
	animationState.travel("Roll")
	velocity = roll_vector * ROLL_SPEED
	
	move_and_slide()
	
func roll_animation_finished():
	state = MOVE


func _on_hurtbox_area_entered(area):
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.5)
	health -= area.damage
	var playerHurtSound = PlayerHurtSound.instantiate()
	get_parent().add_child(playerHurtSound)
	print("hello!")
	emit_signal("health_changed", health)
	if health <= 0:
		queue_free()
	

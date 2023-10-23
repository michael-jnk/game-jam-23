extends CharacterBody2D

var knockback = Vector2.ZERO
@export var health = 5
var state = IDLE
var MAX_SPEED = 50

const ACCELLERATION = 200

@onready var world = $/root/World


enum {
	IDLE,
	WANDER,
	CHASE
}

@onready var hurtbox = $Hurtbox
@onready var wanderController = $WanderController
@onready var  detectionZone = $PlayerDetectionZone
@onready var sprite = $animatedBat
@onready var softCollision = $SoftCollision
const EnemyDeathEffect = preload("res://Effects/enemy_death_effect.tscn")
const BigEnemyDeathEffect = preload("res://Effects/big_enemy_death_effect.tscn")
@onready var visibilityController = $"Enemy Visibility Controller"

@onready var hitbox = $Hitbox

const corpse = preload("res://World/corpse.tscn")
#var corpseLoc = Vector2.ZERO
# unnecessary :grimace:
@onready var darkness = $PointLight2D
var MAX_ENERGY

func _ready():
	MAX_ENERGY = darkness.energy

func _physics_process(delta):
	match state:
		IDLE:
			knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
			velocity = knockback
			
			if wanderController.get_time_left() <= .1:
				
				state = pick_random_state([IDLE, WANDER])
				
				wanderController.set_wander_timer(randf_range(1, 3))
			if detectionZone.player_is_detected():
				state = CHASE
		WANDER: 
			if wanderController.get_time_left() <= .1:
				state = pick_random_state([IDLE, WANDER])
				wanderController.set_wander_timer(randf_range(1, 3))
			accellerate_towards(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= 1:
				state = pick_random_state([IDLE, WANDER])
				wanderController.set_wander_timer(randf_range(1,2))
			
			if detectionZone.player_is_detected():
				state = CHASE 
		CHASE:
			var player = detectionZone.player
			if player != null:
				accellerate_towards(player.global_position, delta)
			if not detectionZone.player_is_detected():
				state = IDLE
			sprite.flip_h = velocity.x < 0
			
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
	if health <= 0:
		world.enemy_died(false)
		var enemyDeathEffect = EnemyDeathEffect.instantiate()
		var bigDeathEffect = BigEnemyDeathEffect.instantiate()
		get_parent().add_child(enemyDeathEffect)
		get_parent().add_child(bigDeathEffect)
		bigDeathEffect.global_position = global_position
		bigDeathEffect.flip_h = sprite.flip_h
		bigDeathEffect.get_child(0).self_modulate = Color(0.627,0.243,0.129)
		enemyDeathEffect.global_position = global_position
		
		var enemyCorpse = corpse.instantiate()
		get_parent().add_child(enemyCorpse)
		enemyCorpse.global_position = global_position
		
		queue_free()
	
	
	hitbox.knockback_vector = velocity.normalized()
	
	move_and_slide()
	
	modulate.a = visibilityController.getAlpha()
	darkness.energy = MAX_ENERGY * visibilityController.getAlpha()

func accellerate_towards(point, delta):
	var direction = global_position.direction_to(point)
	knockback = knockback.move_toward(direction * MAX_SPEED, ACCELLERATION * delta)
	velocity = knockback
	sprite.flip_h = velocity.x < 0
		
func _on_hurtbox_area_entered(area):
#	corpseLoc = world.get_node("World "+str((area.get_parent().get_parent().world%2)+1)+"/YSortNode/Player").global_position + (global_position - area.global_position)
# i did not need to add that :skull:
	health -= area.damage
	hurtbox.create_hit_effect()
	knockback = area.get_knockback()
	
	
func pick_random_state(states):
	# THIS IS NOT THE ISSEU
	states.shuffle()
	return states.pop_front()
	

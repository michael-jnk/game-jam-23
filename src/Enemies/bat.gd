extends CharacterBody2D

var knockback = Vector2.ZERO
var health = 3
var state = IDLE
var MAX_SPEED = 80

const ACCELLERATION = 200



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

@onready var hitbox = $Hitbox

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
		var enemyDeathEffect = EnemyDeathEffect.instantiate()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position
		queue_free()
	
	
	hitbox.knockback_vector = velocity.normalized()
	
	move_and_slide()
	

func accellerate_towards(point, delta):
	var direction = global_position.direction_to(point)
	knockback = knockback.move_toward(direction * MAX_SPEED, ACCELLERATION * delta)
	velocity = knockback
	sprite.flip_h = velocity.x < 0
		
func _on_hurtbox_area_entered(area):
	health -= 1
	hurtbox.create_hit_effect()
	knockback = area.get_knockback()
	
	
func pick_random_state(states):
	# THIS IS NOT THE ISSEU
	states.shuffle()
	return states.pop_front()
	

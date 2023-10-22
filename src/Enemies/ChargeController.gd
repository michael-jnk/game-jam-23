extends Node2D

@onready var prepTimer = $PrepTimer
@onready var dashTimer = $DashTimer
@onready var cooldownTimer = $CooldownTimer
@export var chargeTime = 0.75
@export var chargePrepTime = 1
@export var cooldownTime = 1
@export var turnGrace = 0.25
# ^^ the amount of time where bat is charging but not changing target direction

var target = null
var targetVector = Vector2.ZERO

signal charge_prep_done(targetVector)
signal charge_done
signal cooldown_done

var dashing = false
var chargeDone = true

func start_preparing(player):
	target = player
	prepTimer.start(chargePrepTime)
	dashing = false
	chargeDone = true
#	print("start preparing")

func prepare():
	if target == null:
		return
	if (prepTimer.time_left > turnGrace):
		targetVector = (target.global_position - global_position).normalized()

# this one is linked to prep timer
func _on_timer_timeout():
	charge_prep_done.emit(targetVector)
	dashTimer.start(chargeTime)
	dashing = true
	chargeDone = false
#	print("prep timer done!")

#	print("timer done!")
#	if !dashing:
#		charge_prep_done.emit(targetVector)
#		timer.start(chargeTime)
#		dashing = true
#		chargeDone = false
#	else:
#		print("dashing = true")
#
#		if !chargeDone:
#			charge_done.emit()
#			cooldownTimer.start(cooldownTime)
#			chargeDone = true
#			print("cooldown timer started")
#		dashing = false
	

func _on_cooldown_timer_timeout():
	cooldown_done.emit()
	chargeDone = true
#	print("cooldown timer done")


func _on_dash_timer_timeout():
	charge_done.emit()
	cooldownTimer.start(cooldownTime)
	chargeDone = true
	dashing = false
#	print("cooldown timer started")

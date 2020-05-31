extends KinematicBody2D
var pre_sub = preload("res://cross.tscn")

const UP = Vector2(0,-1)

onready var state_machine = $StateMachine
onready var state_attack = $AttakingStage
onready var atack = $attaking/area
var velocity = Vector2()
var move_speed = 200
var gravity = 1200
var jump_velocity = -560
var dir = "right"

func sub_weapon():
	var cross = pre_sub.instance()
	cross.global_position.x = position.x+50
	cross.global_position.y = position.y
	get_parent().add_child(cross)	

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _apply_movement():
	velocity = move_and_slide(velocity, UP)

func _run():
	if dir == "right":
		velocity.x = move_speed
		$Sprite.flip_h = false
	elif dir == "left":
		velocity.x = -move_speed
		$Sprite.flip_h = true

func lado(l):
	$Sprite.flip_h = l

func _idle():
	velocity.x = 0

func _jump():
	velocity.y = jump_velocity


func _attack():
	atack.disabled = false
	
func _assign_animation(anim):
	$Sprite.play(anim)

func _anim(anim):
	get_node("anim").play(anim)

func dis_ata():
	atack.disabled = true

func vira():
	pass
	#$attaking.rotation_degrees+=180
	
func on_crunch():
	atack = $attaking/area2
	$Collision.disabled = true
	$CollisionDown.disabled = false

func on_stand():
	atack = $attaking/area
	$Collision.disabled = false
	$CollisionDown.disabled = true

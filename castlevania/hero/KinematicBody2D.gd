extends KinematicBody2D
var um = preload("res://sub_weapon/cross.tscn")
var dois = preload("res://sub_weapon/axe.tscn")
var pre_sub

const UP = Vector2(0,-1)

signal hit
onready var state_machine = $StateMachine
onready var state_attack = $AttakingStage
onready var atack = $attaking/area
var velocity = Vector2()
var move_speed = 200
var gravity = 1200
var jump_velocity = -560
var dir = "right"
var num_ar = 0

func _ready():
	pre_sub = um

func _input(event):
	if event.is_action_pressed("next"):
		num_ar = (num_ar+1)%2
		match num_ar:
			0:
				pre_sub = um
			1:
				pre_sub = dois

func sub_weapon():
	#print("camera ",$Camera2D.limit_right,$Camera2D.position)
	var cross = pre_sub.instance()
	cross.global_position.x = position.x+50
	cross.global_position.y = position.y
	get_parent().add_child(cross)

func _apply_gravity(delta):
	velocity.y += gravity * delta

func _apply_movement():
	velocity = move_and_slide(velocity, UP)

func _run():
	#print(dir)
	if dir == "right":
		velocity.x = move_speed
		#$Sprite.flip_h = false
		#$attaking.set_scale(Vector2(1, 1))
	elif dir == "left":
		velocity.x = -move_speed
		#$Sprite.flip_h = true
		#$attaking.set_scale(Vector2(-1, 1))

#func lado(l):
#	$Sprite.flip_h = l

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
	if dir == "left":
		$attaking.set_scale(Vector2(-1, 1))
		$Sprite.flip_h = true
	else:
		$attaking.set_scale(Vector2(1, 1))
		$Sprite.flip_h = false
	#$attaking.rotation_degrees+=180
	
func on_crunch():
	atack = $attaking/area2
	$Collision.disabled = true
	$CollisionDown.disabled = false

func on_stand():
	atack = $attaking/area
	$Collision.disabled = false
	$CollisionDown.disabled = true


func _on_attaking_body_entered(body):
	body.dano()
	emit_signal("hit")

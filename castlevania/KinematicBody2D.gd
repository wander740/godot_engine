extends KinematicBody2D

const UP = Vector2(0,-1)

var velocity = Vector2()
var move_speed = 200
var gravity = 1200
var jump_velocity = -560
var dir = "right"

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

func _idle():
	velocity.x = 0

func _jump():
	velocity.y = jump_velocity

func _assign_animation(anim):
	$Sprite.play(anim)

func _anim(anim):
	print("anim")
	get_node("anim").play(anim)
	print("anim2")

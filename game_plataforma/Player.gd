extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 1000
const SPEED = 200
const JUMP = -550
var motion = Vector2()
var life = 3
onready var is_invulnerable = false

#delta frame
func _physics_process(delta):
	#var motion
	#if !is_invulnerable:
	#	motion = movedir
	
	#gravidade
	motion.y += GRAVITY*delta
	#motion.x = Input.get_action_strength("ui_right")\
	# - Input.get_action_strength("ui_left")
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.play("run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.play("run")
		$Sprite.flip_h = true
	else:
		motion.x = 0
		$Sprite.play("idle")
		
	#se tiver no chão
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP
			
	else:
		$Sprite.play("jump")
		
	motion = move_and_slide(motion,UP)
		#move_and_collide(Vector2(0,-1).rotated(global_position.angle_to_point(get_node("/root/Monster").get_position()))*SPEED*delta)
		#move_and_slide()
		#move

func _on_pes_body_entered(body):
	print(body)
	body.dano()
	motion.y = JUMP

func _on_Area2D_body_entered(body):
	if !is_invulnerable:
		life -= 1
		if life > 10 :
			
			get_tree().change_scene("res://Menu.tscn")
			#$".".queue_free()
		
		#$invulnerability.start()
		#is_invulnerable = true
		#get_node("anin").play("a")
		
		var knol = global_position - body.global_position
		motion.x = sign(knol.x) * (SPEED*20)
		motion.y = -200 
		motion = move_and_slide(motion, UP)


func _on_VisibilityNotifier2D_screen_exited():
	pass
	#get_tree().change_scene("res://Menu.tscn")


func _on_timer_timeout():
	print("life")
	is_invulnerable = false

extends "res://StateMachine.gd"

enum {IDLE,JUMP,FALL,RUN,DOWN,ATTACK}
var m_ant

func _move():
	if Input.is_action_pressed("move_right"):
		parent.dir = "right"
		return true
	if Input.is_action_pressed("move_left"):
		parent.dir = "left"
		return true
	return false

func _ready():
	call_deferred("set_state", IDLE)

func _state_logic(delta):
	parent._apply_gravity(delta)
	parent._apply_movement()

func _get_transition(delta):
	match state:
		IDLE:
			if Input.is_action_pressed("jump"):
				return JUMP
			elif _move():
				return RUN
			elif Input.is_action_pressed("down"):
				return DOWN
			elif Input.is_action_pressed("attack"):
				return ATTACK
		RUN:
			m_ant = parent.dir
			var m = _move()
			if parent.velocity.y > 0 :
				return FALL
			elif Input.is_action_pressed("jump"):
				return JUMP
			elif Input.is_action_pressed("down"):
				return DOWN
			elif Input.is_action_pressed("attack"):
				return ATTACK
			elif !m:
				return IDLE
			elif m_ant != parent.dir:
				return RUN
		JUMP:
			if parent.velocity.y >= 0:
				return FALL
			elif Input.is_action_pressed("attack"):
				return ATTACK
			elif _move():
				return RUN
		FALL:
			if parent.is_on_floor():
				return IDLE
			elif Input.is_action_pressed("attack"):
				return ATTACK
			elif _move():
				return RUN
		DOWN:
			if !Input.is_action_pressed("down"):
				return IDLE
			elif Input.is_action_pressed("attack"):
				return ATTACK
		ATTACK:
			pass
	return null

func _enter_state(new_state, old_state):
	match new_state:
		IDLE:
			parent._idle()
			parent._assign_animation("idle")
		RUN:
			parent._run()
			if old_state == JUMP || old_state == FALL:
				call_deferred("st",old_state)
			else:
				parent._assign_animation("run")
		JUMP:
			parent._jump()
			parent._assign_animation("jump")
		FALL:
			parent._assign_animation("fall")
		DOWN:
			parent._idle()
			parent._assign_animation("duck")
		ATTACK:
			pass

func _exit_state(old_state,new_state):
	pass

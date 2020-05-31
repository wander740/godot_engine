extends "res://StateMachine.gd"

enum {IDLE,JUMP,FALL,RUN,DOWN}
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
	if parent.state_attack.state!=parent.state_attack.NONE:
		return null
	match state:
		IDLE:
			m_ant = parent.dir
			var m = _move()
			if Input.is_action_pressed("jump"):
				return JUMP
			elif m:
				if m_ant != parent.dir:
					parent.vira()
				return RUN
			elif Input.is_action_pressed("down"):
				return DOWN
		RUN:
			m_ant = parent.dir
			var m = _move()
			if parent.velocity.y > 0 :
				return FALL
			elif Input.is_action_pressed("jump"):
				return JUMP
			elif Input.is_action_pressed("down"):
				return DOWN
			elif !m:
				return IDLE
			elif m_ant != parent.dir:
				parent.vira()
				return RUN
		JUMP:
			m_ant = parent.dir
			var m = _move()
			if parent.velocity.y >= 0:
				return FALL
			elif m:
				if m_ant != parent.dir:
					parent.vira()
				return RUN
		FALL:
			m_ant = parent.dir
			var m = _move()
			if parent.is_on_floor():
				return IDLE
			elif m:
				if m_ant != parent.dir:
					parent.vira()
				return RUN
		DOWN:
			m_ant = parent.dir
			_move()
			if !Input.is_action_pressed("down"):
				return IDLE
			elif m_ant != parent.dir:
				parent.vira()
				return DOWN
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
			if parent.dir == "right":
				parent.lado(false)
			else:
				parent.lado(true)
			parent._idle()
			parent._assign_animation("duck")
			parent.on_crunch()

func _exit_state(old_state,new_state):
	match old_state:
		DOWN:
			parent.on_stand()

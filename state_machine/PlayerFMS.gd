extends "res://StateMachine.gd"

enum {IDLE,JUMP,FALL,RUN}
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
	#add_state("idle")
	#add_state("jump")
	#add_state("fall")
	#add_state("run")
	call_deferred("set_state", IDLE)
	
#func _input(event):
#	if event.is_action_pressed("jump") && parent.is_on_floor():
#		parent.velocity.y = parent.jump_velocity

func _state_logic(delta):
	#parent._handle_move_input()
	parent._apply_gravity(delta)
	parent._apply_movement()
	
func _get_transition(delta):
	match state:
		IDLE:
			if Input.is_action_pressed("jump"):
				return JUMP
			elif _move():
				return RUN
				
		RUN:
			m_ant = parent.dir
			var m = _move()
			if parent.velocity.y > 0 :
				return FALL
			elif Input.is_action_pressed("jump"):
				return JUMP
			elif !m:
				return IDLE
			elif m_ant != parent.dir:
				return RUN
				
		JUMP:
			if parent.velocity.y >= 0:
				return FALL
			elif _move():
				return RUN
	
		FALL:
			if parent.is_on_floor():
				return IDLE
			elif _move():
				return RUN
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
				parent._assign_animation("move")
		JUMP:
			parent._jump()
			parent._assign_animation("jump")
		FALL:
			parent._assign_animation("fall")
	
func _exit_state(old_state,new_state):
	pass

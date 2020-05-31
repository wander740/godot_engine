extends Node
class_name StateMachine

#var states = {}
var state = null setget set_state
var previus_state = null

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		_state_logic(delta)
		var transition = _get_transition(delta)
		if transition != null:
			set_state(transition)

func _state_logic(delta):
	pass
	
func _get_transition(delta):
	return null
	
func _enter_state(new_state, old_state):
	pass
	
func _exit_state(old_state,new_state):
	pass

func set_state(new_state):
	previus_state = state
	state = new_state
	if previus_state != null:
		_exit_state(previus_state,new_state)
	if new_state != null:
		_enter_state(state,previus_state)
	
func st(old_state):
	previus_state = state
	state = old_state

#func add_state(state_name):
#	states[state_name] = states.size()

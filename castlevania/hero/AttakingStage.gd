extends StateMachine

enum {NONE,ATTACK,SUB}
var p = false

func _ready():
#	add_state("NONE")
#	add_state("ATTACK")
#	add_state("SUB")
	call_deferred("set_state", NONE)

func _get_transition(delta):
	if [parent.state_machine.JUMP,parent.state_machine.FALL].has(parent.state_machine.state):
		return null
	match state:
		NONE:
			if Input.is_action_pressed("attack"):
				p = true
				return ATTACK
			elif Input.is_action_just_pressed("weapon"):
				p = true
				return SUB
		ATTACK:
			if !p:
				return NONE
		SUB:
			if !p:
				return NONE
	return null
	
func _enter_state(new_state, old_state):
	parent.vira()
	match new_state:
		NONE:
			parent.state_machine.set_state(parent.state_machine.state)
		SUB:
			parent._idle()
			parent._anim("sub")
		ATTACK:
			match parent.state_machine.state:
				parent.state_machine.IDLE:
					parent._anim("ata_idle")
				parent.state_machine.RUN:
					parent._idle()
					parent._anim("ata_idle")
				parent.state_machine.DOWN:
					parent._anim("ata_duck")
				parent.state_machine.JUMP:
					p = false
				parent.state_machine.FALL:
					p = false

func _on_anim_animation_finished(anim_name):
	if anim_name=="sub":
		p = false
	else:
		parent.dis_ata()
		p = false

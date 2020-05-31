extends Node2D

var max_dist = 250
var dir = Vector2(1,0)
var vel = 150

enum {GOING, RETURNING, STOP}
var state = GOING
var ret_dir

onready var init_pos = global_position

func _ready():
	$AnimatedSprite.play("move")

func _process(delta):
	match state:
		GOING:
			translate(dir*vel*delta)
			if global_position.distance_to(init_pos) > max_dist:
				state = RETURNING
				ret_dir = (init_pos - global_position).normalized()
		RETURNING:
			translate(ret_dir*vel*delta)
			if global_position.distance_to(init_pos) < 100:
				queue_free()

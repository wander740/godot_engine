extends KinematicBody2D

var y
func _ready():
	$AnimatedSprite.play("default")
	y = $".".position.y

func _physics_process(delta):
	$".".position.x -= 2.5
	$".".position.y = sin(deg2rad($".".position.x))*50+y
	print(sin(deg2rad($".".position.x))*50)

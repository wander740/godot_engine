extends Node2D

var velocity = Vector2(1,0)
var gravity = 50
var pri = true

func _ready():
	$AnimatedSprite.play("default")

func _process(delta):
	velocity.y += gravity * delta
	if pri:
		velocity.x += 100 * delta
		velocity.y -= 300 * delta
		pri = false
	translate(velocity)

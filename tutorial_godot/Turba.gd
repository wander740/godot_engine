extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.
var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	

func _on_Visibilidade_screen_exited():
	queue_free()
	#func _physics_process(delta):
	#	if not get_node("notifier").is_on_screen():
	#    	queue_free()
	#func _ready():
	#    get_node("notifier").connect("screen_exited", self, "_on_screen_exited")
	#func _on_screen_exited():
	#    queue_free()
	
func _on_start_game():
	queue_free()

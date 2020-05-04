extends StaticBody2D

var flip = true
var pos_ini
var pos_fin 
var vel = 1

func _ready():
	$Sprite.play("walk")
	pos_ini = $".".position.x
	pos_fin = pos_ini + 100
	
#_process loop
func _process(delta):
	if pos_ini <= pos_fin and flip:
		$".".position.x += vel
		$Sprite.flip_h = false
		if $".".position.x >= pos_fin:
			flip = false
	if $".".position.x >= pos_ini and !flip:
		$".".position.x -= vel
		$Sprite.flip_h = true
		if $".".position.x <= pos_ini:
			flip = true

func dano():
	print("morreu")
	#$".".queue_free()
	#get_node("anin").play("die")

func die():
	$".".queue_free()

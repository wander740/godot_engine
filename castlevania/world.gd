extends Node2D

var pre_enemy = preload("res://enemy/enemy.tscn")
var num_enemy = 0
var enemy

func _ready():
	pass 


func _process(delta):
	#print("um ",enemy)
	if num_enemy == 0:
	#print("camera ",$hero.global_position.x," ",$hero.global_position.y)
		enemy = pre_enemy.instance()
		enemy.global_position.x = $hero.global_position.x + 500
		enemy.global_position.y = $hero.global_position.y#+150
		get_parent().add_child(enemy)
		num_enemy = 1
		#print("dois ",enemy)
	
	if enemy != null: 
		
		#print("pos ",enemy.global_position.x)
		if enemy.global_position.x <= 0:
			enemy.queue_free()
			num_enemy = 0


func _on_hero_hit():
	num_enemy = 0

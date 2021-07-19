extends Node2D

func create_grass_effect():
	var GrassEffect = load("res://Effect/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	grassEffect.global_position = global_position
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	queue_free()

func _on_HurtBox_area_entered(area):
	create_grass_effect()

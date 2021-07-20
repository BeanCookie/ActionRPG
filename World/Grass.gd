extends Node2D

const SHIFT_PIXEL = 16

func create_grass_effect():
	var GrassEffect = load("res://Effect/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	grassEffect.global_position.x = global_position.x + SHIFT_PIXEL
	grassEffect.global_position.y = global_position.y + SHIFT_PIXEL
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	queue_free()

func _on_HurtBox_area_entered(area):
	create_grass_effect()

extends KinematicBody2D

const SHIFT_PIXEL = 12

var knockback = Vector2.ZERO

func create_bat_effect():
	var EnemyDeathEffect = load("res://Effect/EnemyDeathEffect.tscn")
	var enemyDeathEffect = EnemyDeathEffect.instance()
	enemyDeathEffect.global_position.x = global_position.x
	enemyDeathEffect.global_position.y = global_position.y - SHIFT_PIXEL
	var world = get_tree().current_scene
	world.add_child(enemyDeathEffect)
	queue_free()
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 150 * delta)
	knockback = move_and_slide(knockback)
	
func _on_HurtBox_area_entered(area):
	if 'knockback_vertor' in area:
		knockback = area.knockback_vertor * 120

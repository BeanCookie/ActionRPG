extends KinematicBody2D

var velocity = Vector2.ZERO

enum {
	MOVE,
	ATTACK
}

# 加速度
const ACCELERATION = 500
# 最大速度
const MAX_SPEED = 100 
# 摩擦力
const FRICTION = 400

# 动画
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = $AnimationTree.get("parameters/playback")
onready var state = MOVE

func _ready():
	animationTree.active = true

func process_move(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		# 限定最大速度
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idel")
		# 设置摩擦力
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attach"):
		state = ATTACK
		velocity = input_vector

func process_attack():
	animationState.travel("Attack")
	
func stop_attack():
	state = MOVE

func _physics_process(delta):
	match state:
		MOVE: process_move(delta)
		
		ATTACK: process_attack()

extends Actor

export var stomp_impulse: = 1000.0

# conventions: leading underscore _var -> means private var

#func _on_EnemyDetector_area_entered(_area):
	#print('event fired')
	#_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
func _on_EnemyDetector_body_entered(body):
	queue_free()

# this func is specific to gadot
func _physics_process(_delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction() # from user controls
	# var _velocity defined on Actor.gd
	_velocity = calculate_move__velocity(_velocity, speed, direction, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL) # move the character

func get_direction() -> Vector2:
	# input lines returns 1 if pressed 0 if not
	# x axis logic: <-- -1 (left) --< center > -- +1(right) -->
	# y axis logic: -1 = up, +1 = down, (its reversed in game engines)
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculate_move__velocity(
		linear__velocity: Vector2, 
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var result: = linear__velocity
	result.x = speed.x * direction.x
	# including delta in calculation will allow character to move at the same speed
	# as the number of frames
	result.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0: # if we are jumping
		result.y = speed.y * -1.0 # move up (neg direction) in the y axis
	if is_jump_interrupted: # if in the air already and key was released
		result.y = 0.0 # drop to ground
	return result

# replaces y component (jump) with impulse which pushes the player up
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var result: = linear_velocity
	result.y = -impulse
	return result

extends "res://src/Actors/Actor.gd"

# is called on every node in the scene
func _ready() -> void:
	set_physics_process(false) # deactivates enemy at the start when its not visible
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body):
	# when something enters the stomp area
	# check if the body position is LOWER than the stomp area
	if body.global_position.y < get_node("StompDetector").global_position.y:
		return # stop the function here
	#get_node("CollisionShape2D").disabled = true # stops u from colliding with enemy
	queue_free() # deletes the enemy - queues a node for deletion

func _physics_process(delta: float) -> void: # code starts when enemy is in view
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0 # switch direction
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y # moves enemy
	

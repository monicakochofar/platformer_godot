extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL = Vector2.UP
# setting max speed so it doesnt go to infinity
export var speed: = Vector2(300.0, 1000.0)

# applied on vertical axis - an acceleration in that direction
# export keyword makes the value appear on the right
export var gravity: = 4000.0

# character will not move
var _velocity: = Vector2.ZERO
# Vector2(300, 0) -> will always go to the right

# a function that is called many times per frame
# delta is a value that the engine gives us - time elapsed since previous frame
#func _physics_process(delta):

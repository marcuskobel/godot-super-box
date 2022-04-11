extends KinematicBody2D

export var speed = 64
export var health = 1
var velocity = Vector2.ZERO
var move_direction = -1
var gravity = 1000

func _physics_process(delta):
	# caclulate Y velocity
	velocity.y += gravity * delta
	
	velocity.x = speed * move_direction
	
	velocity = move_and_slide(velocity)

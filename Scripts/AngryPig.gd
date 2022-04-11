extends KinematicBody2D

export var speed = 64
export var health = 1
var velocity = Vector2.ZERO
var move_direction = -1
var gravity = 1000

func _physics_process(delta):
	# caclulate Y velocity
	velocity.y += gravity * delta
	
	# calculate X velocity
	velocity.x = speed * move_direction	
	velocity = move_and_slide(velocity)

	if move_direction == 1:
		$sprite.flip_h = true
	else:
		$sprite.flip_h = false
	
	if $ray_wall.is_colliding():
		#$animation.play()
		move_direction *= -1
		$ray_wall.scale.x *= -1

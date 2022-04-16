extends KinematicBody2D

var move_direction = 0
var velocity = Vector2.ZERO
var move_speed = 120
var gravity = 1000
var jump_force = -320
var is_grounded
onready var raycasts = $raycasts
var got_hurt = false
var knockback_intensity = 200


func _physics_process(delta):
	velocity.y += gravity * delta
	
	_get_input()
	
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_grounded()
	
	_set_animation()


func _get_input():
	#velocity.x = 0
	move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction != 0:
		$sprite.scale.x = move_direction

# acho que essa função é do próprio engine
func _input(event: InputEvent):
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force


func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false


func _set_animation():
	var anim = "idle"
	
	if got_hurt:
		anim = "hurt"
		
	if !is_grounded and velocity.y < 0:
		anim = "jump"
		
	elif !is_grounded and velocity.y > 0:
		anim = "fall"
		
	# here I had to do a minor baka to fix "run" animation which will never go back to exactly 0
	elif velocity.x > 10 or velocity.x < -10:
		anim = "run"
	
	if $animation.assigned_animation != anim:
		$animation.play(anim)


func knock_player_back():
	# quick detail #1. according to code logic, $sprite.scale.x will always contain 1 or -1, nothing else
	# if this changes in the future, this also has to be changed.
	# TO DO: enhance this in the future to make knockback happen in the same direction as the colision is
	# happening, regardless direction  player is going.
	velocity.x = -$sprite.scale.x * knockback_intensity
	velocity = move_and_slide(velocity)


func _on_hurtbox_body_entered(body):
	print(body.name + " has collided.")
	got_hurt = true
	knock_player_back()
	yield(get_tree().create_timer(0.5), "timeout")
	got_hurt = false

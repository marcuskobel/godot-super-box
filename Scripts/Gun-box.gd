extends Area2D


func _on_gunbox_body_entered(body):
	# print(body.name + " collided with gun-box")
	if body.name == "Player":
		$anim.play("dissapear")


func _on_anim_animation_finished(anim_name):
	if anim_name == "dissapear":
		# print("Removing gun-box from scene")
		queue_free()

extends Area2D

var rng = RandomNumberGenerator.new()

#func _ready():
#	pass


func _on_fallzone_body_entered(body):
	# print(body.name)
	
	# reload current scene if player colides with fall zone
	if body.name == "Player":
		get_tree().reload_current_scene()
		
	elif body.name.substr(0,8) == "AngryPig":
		# when pigs colide with fall zone, send them to the top of screen
		body.position.y = 50
		body.position.x = rng.randf_range(40.0, 600.0)
		
		# TO DO: change pig animation and double speed

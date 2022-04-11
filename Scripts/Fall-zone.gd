extends Area2D


func _ready():
	pass


func _on_fallzone_body_entered(body):
	# print(body.name)
	
	# reload current scene if player colides with fall zone
	if body.name == "Player":
		get_tree().reload_current_scene()

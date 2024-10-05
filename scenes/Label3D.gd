extends Label3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	text = str(get_parent().get_parent().bird_list)


func _on_area_3d_body_exited(body):
	text = str(get_parent().get_parent().bird_list)

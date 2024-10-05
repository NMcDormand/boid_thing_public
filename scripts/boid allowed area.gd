extends Area3D
@export var boundingbox: Node 
@onready var section = preload("res://scenes/grid section.tscn")
@onready var bird = preload("res://scenes/bird.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	# loops through every position in the bounding box (x*y*z)
	for x in (get_child(0).scale.x):
		for y in (get_child(0).scale.y):
			for z in (get_child(0).scale.z):
				# creates instances local to this loop for both grid sections and the birds themselves
				var sectioninstance = section.instantiate()
				var birdinstance = bird.instantiate()
				boundingbox.add_child(sectioninstance)
				boundingbox.add_child(birdinstance)
				# sets the position of the current gridsection instance to the current position in the loop 
				sectioninstance.global_position.x = x - x/2
				sectioninstance.global_position.y = y - y/2
				sectioninstance.global_position.z = z - z/2
				# sets the position of the current bird instance to the current position in the loop 
				birdinstance.global_position.x = x - x/2
				birdinstance.global_position.y = y - y/2
				birdinstance.global_position.z = z - z/2
				#adds the bird and section instances to the node tree allowing them to actually run


func _on_body_exited(body):
	body.bird_state = "outside"
	body.update_process_function()

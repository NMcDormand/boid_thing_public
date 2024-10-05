extends Node3D
@onready var bird_list: Array[Node]
#Lead_bird is the bird currently in a section that has been in there the longest.
#this information is passed to the follower birds so they know who to follow 
var lead_bird: Node


#dictates behavior when a bird enteres a grid section
func _on_area_3d_body_entered(body):
#adds the bird to the end of the list
	bird_list.append(body)
#if the bird is at the start of the list make them the leader
	if bird_list[0] == body:
		body.bird_state = "leader"
		body.update_process_function()
#if the bird is not at the start of the list make them a follower
	else:
		body.lead_bird = bird_list[0]
		body.bird_state = "follower"
		body.update_process_function()


#dictates behavior when a bird exits a grid section
func _on_area_3d_body_exited(body):
	#removes the bird from the list
	bird_list.erase(body)
	
	#changes the lead bird to the next in line
	if bird_list.size() > 0:
		lead_bird = bird_list[0]
		#updates every bird in the list with the new leadbird
		for i in bird_list.size():
				bird_list[i].lead_bird = lead_bird
	else:
		lead_bird = null

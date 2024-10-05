extends CharacterBody3D
#the speed of the bird
var speed = 0.03
#this is either a random value or the value of the leader bird based on the bird state
var target_rotation_x: float
var target_rotation_y: float
var target_rotation_z: float
#the state the bird is in (leader,follower,outside)
var bird_state: String
#which bird is considered the leader of the section
var lead_bird: Node
var current_process_func: Callable = leader_function


func _ready():
	update_process_function()
	# Initialize the first random rotation so they dont all start going the same direction
	target_rotation_x = randi_range(0, 360)
	target_rotation_y = randi_range(0, 360)
	target_rotation_z = randi_range(0, 360)

#tells the process function which state to run. this avoids running thousands of IF statements every frame
func update_process_function():
	if bird_state == "leader":
		current_process_func = leader_function
	if bird_state == "follower":
		current_process_func = follower_function
	if bird_state == "outside":
		#makes the bird look back at the center of the map when it leaves the out bounds
		look_at(Vector3.ZERO, Vector3.UP)
		current_process_func = outside_function

#runs a function based on the current state of the bird
func _process(delta):
	current_process_func.call()

#what to do if this bird is the leader
func leader_function():
	# Move the object in its facing direction
	translate(transform.basis.z * speed)
	# Lerp towards the target rotation which will randomly change
	rotation.x = lerp_angle(rotation.x, target_rotation_x, .02)
	rotation.y = lerp_angle(rotation.y, target_rotation_y, .02)
	rotation.z = lerp_angle(rotation.z, target_rotation_z, .02)

#what to do if this bird is the follower
func follower_function():
	# Move the object in its facing direction
	translate(transform.basis.z * speed)
	# Lerp towards the rotation of the lead bird
	rotation.x = lerp_angle(rotation.x, lead_bird.rotation.x, .02)
	rotation.y = lerp_angle(rotation.y, lead_bird.rotation.y, .02)
	rotation.z = lerp_angle(rotation.z, lead_bird.rotation.z, .02)
	
#what to do if this bird is outside the bounds of the box
func outside_function():
	#move in direction the bird is looking
	translate(transform.basis.z * speed)
func _on_timer_timeout():
	# Set a new random target rotation for the leader
	if bird_state == "leader":
		target_rotation_x = randf_range(rotation.x-0.1,rotation.x+0.1)
		target_rotation_y = randf_range(rotation.y-0.1,rotation.y+0.1)
		target_rotation_z = randf_range(rotation.z-0.1,rotation.z+0.1)
	if bird_state == "outside":
		update_process_function()


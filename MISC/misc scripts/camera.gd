extends Position3D

onready var car = get_node("../car")

var default_cam_pos

func _ready():
	default_cam_pos = $orbit/Camera.translation

func _process(delta):
	look_at(get_parent().get_node("car").translation,Vector3(0,1,0))
	translation = get_parent().get_node("car").translation 
	translate_object_local(Vector3(0,0,17))#14.5
	
	$orbit.global_translation = get_parent().get_node("car").global_translation
	$orbit/Camera.translation = default_cam_pos -$orbit.translation

func _physics_process(delta):
	if Input.is_action_pressed("CAM_orbit_left"):
		$orbit.rotation_degrees.y += 1
	elif Input.is_action_pressed("CAM_orbit_right"):	
		$orbit.rotation_degrees.y -= 1
	
	if Input.is_action_pressed("CAM_orbit_reset"):
		$orbit.rotation_degrees.y = 0.0


func _spowner(rotation,position):
	print(position)
	$orbit.rotation_degrees.y = 0   #### si funicona, camera es 0.0
	translation = position + Vector3(0,0,-15.5)
	rotation_degrees = rotation
	$orbit.translation = position 
	$orbit/Camera.translation = rotation+Vector3(0,90,0)
	#$orbit.rotation_degrees = rotation*-1

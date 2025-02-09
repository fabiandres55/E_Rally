extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cam_chase.find_node("Target").visible = false
	$Control.choose_motor_selection = Pendiente.motor_choose_trueorfalse
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Salida_body_entered(body):
	$Control.start_time = true
	pass # Replace with function body.


func _on_Llegada_body_entered(body):
	$Control.start_time = false
	$Control.ordenamineto_de_jugadores(Pendiente.motor_choose_trueorfalse)
	$Control.find_node("Results").visible = true
	get_tree().paused = true
	pass # Replace with function body.

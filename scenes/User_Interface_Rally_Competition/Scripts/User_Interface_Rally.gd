extends Control



############### colider_TIMER: 
export var start_time = false
###############################
##### motor correct_ o incorrect: 
export var choose_motor_selection = false

###### exit:
var exit = false


var centseconds = 0
var seconds =0
var centi_truncado 
var minute = 0
##### var tiempo_total: 
var Tiempo_Total


# Called when the node enters the scene tree for the first time.
func _ready():
	$Results.visible = false
	$Telon.visible = false
	pass # Replace with function body.

func _process(delta):
	### timer system:
	if start_time == true: 
		centseconds += delta
		if centseconds < 1:
			centi_truncado = numero_truncado(centseconds)
		else: 
			centseconds = 0
			if seconds<60:
				seconds += 1
			else: 
				seconds = 0
				if minute <60: 
					minute += 1
				else: 
					minute=0
		Tiempo_Total = "{minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds,"centiseconds":centi_truncado})
		$Time_.text = Tiempo_Total
	pass

func numero_truncado(centisegundo):
	centisegundo = floor(centisegundo*1000)
	return centisegundo

func ordenamineto_de_jugadores(choose_motor):
	$AudioStreamPlayer.play()
	if choose_motor == true:
		get_node("Results/VBoxContainer/1/User").text = "1, Usted             {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds,"centiseconds":centi_truncado})
		####color: 
		get_node("Results/VBoxContainer/1/User").modulate = Color(255,0,0)
		get_node("Results/VBoxContainer/2/User").text = "2, Valentina García  {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds+4,"centiseconds":centi_truncado+2})
		get_node("Results/VBoxContainer/3/User").text = "3, Alejandro Mendoza {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds+6,"centiseconds":centi_truncado+3})
		get_node("Results/VBoxContainer/4/User").text = "4, Carolina Torres   {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds+7,"centiseconds":centi_truncado+5})
		get_node("Results/VBoxContainer/5/User").text = "5, Andrés Ramírez    {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds+8,"centiseconds":centi_truncado+10})
	else: 
		get_node("Results/VBoxContainer/1/User").text = "1, Carolina Torres   {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds-7,"centiseconds":centi_truncado-5})
		###### color : 
		get_node("Results/VBoxContainer/1/User").modulate = Color(255,255,255)
		get_node("Results/VBoxContainer/2/User").text = "2, Valentina García  {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds-6,"centiseconds":centi_truncado-4})
		get_node("Results/VBoxContainer/3/User").text = "3, Alejandro Mendoza {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds-5,"centiseconds":centi_truncado-3})
		get_node("Results/VBoxContainer/4/User").text = "4, Usted             {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds,"centiseconds":centi_truncado})
		####### color: $cortina.play_backwards("Intro_exit")
		get_node("Results/VBoxContainer/4/User").modulate = Color(255,0,0)
		get_node("Results/VBoxContainer/5/User").text = "5, Andrés Ramírez    {minutes}:{seconds}.{centiseconds}".format({"minutes":minute,"seconds":seconds+1,"centiseconds":centi_truncado+4})
	pass

func _on_Exit_pressed():
	if Pendiente.portales_secuancia_logica ==1 and Pendiente.motor_choose_trueorfalse == true:
		Pendiente.portales_secuancia_logica = 2
	elif Pendiente.portales_secuancia_logica ==2 and Pendiente.motor_choose_trueorfalse == true:
		Pendiente.portales_secuancia_logica = 3
	elif Pendiente.portales_secuancia_logica ==3 and Pendiente.motor_choose_trueorfalse == true:
		Pendiente.portales_secuancia_logica = 4
	elif Pendiente.portales_secuancia_logica ==4 and Pendiente.motor_choose_trueorfalse == true: 
		Pendiente.portales_secuancia_logica = 5
	elif Pendiente.portales_secuancia_logica==0 and Pendiente.motor_choose_trueorfalse == true: 
		Pendiente.portales_secuancia_logica = 1
	$Telon.visible = true
	$Timer.start()
	pass # Replace with function body.
	

func _on_Timer_timeout():
	get_tree().change_scene("res://world.tscn")
	pass # Replace with function body.

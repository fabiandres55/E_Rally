extends Control


var valor_entrada 
var Error = false
var Next_scene = false
var Back_scene = false

var Dominio = 0.58  #*1000
var Rango = 192
var time = -600

var motor_seleccionado = 0
#################################
var motor_vista = 0     ### m_1 : 0, m_2 : 1 ... etc

####### valor correcto: 
var valor_correcto = -0.1
# Called when the node enters the scene tree for the first time.
###### variable de next_Rally_1:
var Next_Rally_1 = false
##### SELECCION DEL MOTOR: 
var Motor_Type = null


func _process(delta):
	### primera_funcion:
	if Dominio>= time:
		time += delta*100
		
		var y = (50.00000000000025)/(1+0.000000000000006*exp(0.061*time))
		$Motor/Motor_container/Motor_graficos._trayectoria_funcion_particula(time,y)
		
		var y_2 = (192.9175)/(1+0.0183*exp(0.0237*time)) ###3 true
		$Motor/Motor_container/Motor_graficos2._trayectoria_funcion_particula(time,y_2)
		
		var y_3 = (87.1783)/(1+0.0006*exp(0.0126*time))
		$Motor/Motor_container/Motor_graficos3._trayectoria_funcion_particula(time,y_3)
		
		###### Motor eror: 
		var y_4 = (157.2052)/(1+0.0321*exp(0.0117*time))
		$Motor/Motor_container/Motor_graficos4._trayectoria_funcion_particula(time,y_4)
		#########grafico en Infromacion: 
		var y_G = (-0.18*time)+110
		$Information/Motor_graficos_Infroma._trayectoria_funcion_particula(time,y_G)
	########## selecion de motores: 
	pass

func _evaluacion_punto(dominio):
	if dominio<= 600 and dominio> -600 : 
		
		var y = (50.00000000000025)/(1+0.000000000000006*exp(0.061*dominio))
		$Motor/Motor_container/Motor_graficos._punto_position(dominio,y)
		
		var y_2 = (192.9175)/(1+0.0183*exp(0.0237*dominio))  ### true
		$Motor/Motor_container/Motor_graficos2._punto_position(dominio,y_2)
		
		var y_3 = (87.1783)/(1+0.0006*exp(0.0126*dominio))
		$Motor/Motor_container/Motor_graficos3._punto_position(dominio,y_3)
		var y_4 = (157.2052)/(1+0.0321*exp(0.0117*dominio))
		$Motor/Motor_container/Motor_graficos4._punto_position(dominio,y_4)
	pass

func _ready():
	$Plano.p_llegada_x = 0
	$Plano.p_llegada_y =  0
	$Plano.p_Inicio_y = 300
	$Plano.p_Inicio_x = -3000
	
	$Input/Correcto.visible = false
	$Input/Error.visible = false
	$Information.visible = false
	$vamos.visible = false
	$Buttons/Con/Go.visible = false
	$Motor.visible = false
	$Buttons/Con/Motor.visible = false
	###### calculo de la pendiente: 
	#### queda como tarea. 
	###### Dominio
	Dominio = Dominio*1000
	####### Grafico de Informacion punton de visualizacion: 
	#$Information/Motor_graficos_Infroma._punto_position(70,120)
	$Information/Motor_graficos_Infroma._punto_position(0.07*1000,97.17)
	
	
	$Information/Motor_graficos_Infroma.find_node("Bola").modulate = Color(0, 0.952941, 1)
	$Information/Motor_graficos_Infroma.find_node("trayecto").modulate = Color(0, 0.952941, 1)
	######Dando color a los graficos motor : 
	$Motor/Motor_container/Motor_graficos.find_node("Bola").modulate = Color(1, 0, 0)
	$Motor/Motor_container/Motor_graficos.find_node("trayecto").modulate = Color(1, 0, 0)
	##
	$Motor/Motor_container/Motor_graficos2.find_node("Bola").modulate = Color(1, 0.537255, 0)
	$Motor/Motor_container/Motor_graficos2.find_node("trayecto").modulate = Color(1, 0.537255, 0)
	#
	$Motor/Motor_container/Motor_graficos3.find_node("Bola").modulate = Color(0.827451, 1, 0)
	$Motor/Motor_container/Motor_graficos3.find_node("trayecto").modulate = Color(0.827451, 1, 0)
	#Color(1, 0, 0)
	$Motor/Motor_container/Motor_graficos4.find_node("Bola").modulate = Color(1, 0.537255, 0)
	$Motor/Motor_container/Motor_graficos4.find_node("trayecto").modulate = Color(1, 0.537255, 0)
	pass # Replace with function body.

func _Window(valor):# valor: 0 Infromacion, 1:Mapa, 2,Motor  3,Vamos..
	$Texto.visible = false
	$Input.visible = false
	$Plano.visible = false
	$ColorRect.visible = false
	$Information.visible = false
	$vamos.visible = false
	$Motor.visible = false
	if valor == 1:
		$Texto.visible = true
		$Input.visible = true
		$Plano.visible = true
		$ColorRect.visible = true
	elif valor ==0:
		$Information.visible = true
	elif valor ==2:###################################
		_motor_vista(motor_vista)
		$Motor.visible = true
		##################################
	elif valor == 3:
		$vamos.visible = true

func aviso_Error(bol):
	if bol == true:
		$Input/Error.visible = true
		$Input/Correcto.visible = false
	else: 
		$Input/Error.visible = false
		$Input/Correcto.visible = true

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ENTER and event.pressed:
			valor_entrada = $Input/LineEdit.text
			valor_entrada = valor_entrada.replace(",",".")
			if valor_entrada.is_valid_float() :  ### aqui verifica si es float o no. $Input/LineEdit.text.is_valid_float(): 
				valor_entrada = float(valor_entrada)
				if valor_entrada <= 0.58 and valor_entrada>=-0.58: #### aqui el valor de entrada tiene que estra en el rango -0.58 y 0.58:
					aviso_Error(false)
					$Input/Correcto.text = "La pendiente que calculaste es: " + str(valor_entrada) + " Lo tengo."
					$Input/LineEdit.clear()
					_evaluacion_punto(valor_entrada*1000)
					$Buttons/Con/Motor.visible = true
					$Motor/Titulo/Text_pendiente.text = "La pendiente que calculaste es {m} estos son los desempeños de los motores".format({"m":valor_entrada})
				else: 
					Error = true
					aviso_Error(true)
					$Input/LineEdit.clear()
			else: 
				Error = true
				aviso_Error(true)
				$Input/LineEdit.clear()
	pass

func _on_Info_pressed():
	_Window(0)
	pass # Replace with function body.

func _on_Map_pressed():
	_Window(1)
	pass # Replace with function body.

func _on_Motor_pressed():
	_Window(2)
	pass # Replace with function body.

func _on_Go_pressed():
	$vamos/text.text = "Muy bien, equipo! Es hora de poner motores a rugir y emociones a mil. Nos espera un emocionante rally lleno de desafíos y aventuras."
	$vamos/Next_scene.visible = true
	
	# aqui el valor siempre sera verdad!  
	_Window(3)
	pass # Replace with function body.


func _on_cortina_animation_finished(anim_name):
	if Back_scene == true:
		Back_scene = false
		get_tree().change_scene("res://world.tscn")
	if Next_Rally_1 == true:
		Next_Rally_1 = false
		get_tree().change_scene("res://scenes/Motor_selection_2/Rally_1/Rally_1.tscn")
	pass # Replace with function body.

func _on_Exit_pressed():
	$cortina.play_backwards("Intro_exit")
	Back_scene = true
	pass # Replace with function body.


func _on_Button_pressed():
	motor_seleccionado = 0
	_selec_motor(motor_seleccionado)
	pass # Replace with function body.


func _on_Button_2_pressed():
	motor_seleccionado = 1
	_selec_motor(motor_seleccionado)
	pass # Replace with function body.


func _on_Button_3_pressed():
	motor_seleccionado = 2
	_selec_motor(motor_seleccionado)
	pass # Replace with function body.





func _selec_motor(num):
	$Buttons/Con/Go.visible = true
	$Motor/Motor_container/Motor_graficos/Button.pressed = false
	$Motor/Motor_container/Motor_graficos2/Button_2.pressed = false
	$Motor/Motor_container/Motor_graficos3/Button_3.pressed = false
	$Motor/Motor_container/Motor_graficos4/Button_4.pressed = false
	if num == 0:
		$Motor/Motor_container/Motor_graficos/Button.pressed = true
		Motor_Type =  [2.0,2.0,2.0,2.0, 2.0] # 3.250, 1.894, 1.259, 0.937, 0.9
	elif num == 1:
		$Motor/Motor_container/Motor_graficos2/Button_2.pressed = true
		Motor_Type = [3.250, 1.894, 1.259, 0.937, 0.9] ### True
	elif num == 2: 
		$Motor/Motor_container/Motor_graficos3/Button_3.pressed = true
		Motor_Type = [3.5, 3.5,3.5, 3.5, 3.5]
	elif num ==3:
		$Motor/Motor_container/Motor_graficos4/Button_4.pressed = true
		Motor_Type = [1.2, 1.2, 1.2, 1.2, 1.2]

func _motor_vista(num):
	$Motor/Motor_container/Motor_graficos.visible = false
	$Motor/Motor_container/Motor_graficos2.visible = false
	$Motor/Motor_container/Motor_graficos3.visible = false
	$Motor/Motor_container/Motor_graficos4.visible = false
	if num == 0:
		$Motor/Motor_container/Motor_graficos.visible = true
	elif num == 1: 
		if valor_entrada*100  == valor_correcto*100:
			$Motor/Motor_container/Motor_graficos2.visible = true
		else:
			$Motor/Motor_container/Motor_graficos4.visible = true
	elif num == 2: 
		$Motor/Motor_container/Motor_graficos3.visible = true


func _on_M_1_pressed():
	motor_vista = 0
	_motor_vista(motor_vista)
	pass # Replace with function body.


func _on_M_2_pressed():
	motor_vista = 1
	_motor_vista(motor_vista)
	pass # Replace with function body.


func _on_M_3_pressed():
	motor_vista = 2
	_motor_vista(motor_vista)
	pass # Replace with function body.




func _on_Next_scene_pressed():
	$cortina.play_backwards("Intro_exit")
	Pendiente.motor_propieties = Motor_Type
	if motor_seleccionado == 1:
		Pendiente.motor_choose_trueorfalse = true
	else: 
		 Pendiente.motor_choose_trueorfalse = false
	Next_Rally_1 = true
	pass # Replace with function body.


func _on_Button_4_pressed():
	motor_seleccionado = 3
	_selec_motor(motor_seleccionado)
	pass # Replace with function body.

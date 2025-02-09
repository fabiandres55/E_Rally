extends Control


#######
var minutos = 0
var seg = 0
var start_timer = false
#################### key,spowner
var Key_spowner = 0
################# var entro o salio de un portal: 
var logic_portals_0 = false
var logic_portals_1 = false
var logic_portals_2  = false
var logic_portals_3  = false
var logic_portals_4  = false
############### variabl de pausa: 
var pause_game = false
############################# variable de casa ir menu: 
var casa = false

var changed_graph_size = Vector2(0,0)
export(NodePath) var car



func _ready():
	portal_logic_sysrtem(Pendiente.portales_secuancia_logica)
	get_parent().get_node("debug/Rally_wins").text = "Rally Ganados "+str(Pendiente.portales_secuancia_logica)
	#########
	get_tree().paused = false
	############
	$Pause.visible = false
	##############
	
	get_parent().get_node("debug/Texto_niveles/Next").play_backwards("Next_scene")
	get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play_backwards("up")
	
	##### set target_arrow: 
	if Pendiente.portales_secuancia_logica ==0:
		get_parent().get_node("cam_chase/orbit/Camera/Arrow2/Target").position_target = get_parent().get_node("Levels/0").global_translation
	elif Pendiente.portales_secuancia_logica ==1: 
		get_parent().get_node("cam_chase/orbit/Camera/Arrow2/Target").position_target = get_parent().get_node("Levels/1").global_translation
	elif Pendiente.portales_secuancia_logica ==2: 
		get_parent().get_node("cam_chase/orbit/Camera/Arrow2/Target").position_target = get_parent().get_node("Levels/2").global_translation
	elif Pendiente.portales_secuancia_logica ==3: 
		get_parent().get_node("cam_chase/orbit/Camera/Arrow2/Target").position_target = get_parent().get_node("Levels/3").global_translation
	elif Pendiente.portales_secuancia_logica ==4: 
		get_parent().get_node("cam_chase/orbit/Camera/Arrow2/Target").position_target = get_parent().get_node("Levels/4").global_translation
	
	
	if not car == "":
		
		for d in get_node(car).get_children():
			if "TyreSettings" in d:
				$vgs.append_wheel(d.translation,d.TyreSettings,d)
		
		for i in $power_graph.get_script().get_script_property_list():
			if not i["name"] == "peakhp" and not i["name"] == "tr" and not i["name"] == "tr" and not i["name"] == "hp" and not i["name"] == "skip" and not i["name"] == "scale":
				if i["name"] in get_node(car):
					$power_graph.set(i["name"], get_node(car).get(i["name"]))


func _process(delta):
	########## scroll sounds settings: 
	$Pause/VBoxContainer/Ajustes/Sound_car/porcentaje.text = str($Pause/VBoxContainer/Ajustes/Sound_car.value)+"%"
	$Pause/VBoxContainer/Ajustes/Sound_enviroment/porcentaje.text = str($Pause/VBoxContainer/Ajustes/Sound_enviroment.value)+"%"
	######sonido enviroment: 
	get_parent().get_node("Audio/AudioStreamPlayer").volume_db = 0.35*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value-30
	
	get_parent().get_node("Audio/Bird_0").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_1").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_2").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_3").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_4").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_5").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_6").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	
	get_parent().get_node("Audio/Bird_0").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_1").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_2").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	get_parent().get_node("Audio/Bird_3").unit_db = (0.8*$Pause/VBoxContainer/Ajustes/Sound_enviroment.value)-50
	######### logic_portals: 
	if logic_portals_0 == true and Input.is_action_pressed("Enter_portal"):
		 get_parent().get_node("debug/Texto_niveles/Next").play("Next_scene")
	if logic_portals_1 == true and Input.is_action_pressed("Enter_portal"):
		get_parent().get_node("debug/Texto_niveles/Next").play("Next_scene")
	if logic_portals_2 == true and Input.is_action_pressed("Enter_portal"):
		get_parent().get_node("debug/Texto_niveles/Next").play("Next_scene")
	if logic_portals_3 == true and Input.is_action_pressed("Enter_portal"):
		get_parent().get_node("debug/Texto_niveles/Next").play("Next_scene")
	if logic_portals_4 == true and Input.is_action_pressed("Enter_portal"):
		get_parent().get_node("debug/Texto_niveles/Next").play("Next_scene")
	####tiempo
	if start_timer == true:
		if seg <= 60:
			seg += delta 
		else:
			minutos += 1
			seg = 0 
	###### label 
	get_node("Timer/Label2").text = str(minutos)+":"+str(seg)
	######
	if delta>0:
		get_node("container/fps").text = "fps: "+str(1.0/delta)

	if not changed_graph_size == $power_graph.rect_size:
		changed_graph_size = $power_graph.rect_size
		$power_graph._ready()
		
	if not car == "":
		
		$tacho/speedk.text = "KM/PH: " +str(int(get_node(car).linear_velocity.length()*1.10130592))
		$tacho/speedm.text = "MPH: " +str(int((get_node(car).linear_velocity.length()*1.10130592)/1.609 ) )
		
		var hpunit = "hp"
		if $power_graph.Power_Unit == 1:
			hpunit = "bhp"
		elif $power_graph.Power_Unit == 2:
			hpunit = "ps"
		elif $power_graph.Power_Unit == 3:
			hpunit = "kW"
		$hp.text = "Power: %s%s @ %s RPM" % [str( int($power_graph.peakhp[0]*10.0)/10.0 ), hpunit ,str( int($power_graph.peakhp[1]*10.0)/10.0 )]

		var tqunit = "ft⋅lb"
		if $power_graph.Torque_Unit == 1:
			tqunit = "nm"
		elif $power_graph.Torque_Unit == 2:
			tqunit = "kg/m"
		$tq.text = "Torque: %s%s @ %s RPM" % [str( int($power_graph.peaktq[0]*10.0)/10.0 ), tqunit ,str( int($power_graph.peaktq[1]*10.0)/10.0 )]

		$power_graph/rpm.rect_position.x = (get_node(car).rpm/$power_graph.Generation_Range)*$power_graph.rect_size.x -1.0

		$g.text = "Gs: x%s , y%s , z%s " % [str(int(get_node(car).gforce.x*100.0)/100.0),str(int(get_node(car).gforce.y*100.0)/100.0),str(int(get_node(car).gforce.z*100.0)/100.0)]

		$tacho.currentpsi = get_node(car).turbopsi*(get_node(car).TurboAmount)
		$tacho.currentrpm = get_node(car).rpm
		$tacho/rpm.text = str(int(get_node(car).rpm))
		
		if get_node(car).rpm<0:
			$tacho/rpm.self_modulate = Color(1,0,0)
		else:
			$tacho/rpm.self_modulate = Color(1,1,1)
		
		if get_node(car).gear == 0:
			$tacho/gear.text = "N"
		elif get_node(car).gear == -1:
			$tacho/gear.text = "R"
		else:
			if get_node(car).TransmissionType == 1 or get_node(car).TransmissionType == 2:
				$tacho/gear.text = "D"
			else:
				$tacho/gear.text = str(get_node(car).gear)


func _physics_process(delta):
	
	if not car == "":
		$vgs.gforce -= ($vgs.gforce - Vector2(get_node(car).gforce.x,get_node(car).gforce.z))*0.5
		
		$tacho/abs.visible = get_node(car).abspump>0 and get_node(car).brakepedal>0.1
		$tacho/tcs.visible = get_node(car).tcsflash
		$tacho/esp.visible = get_node(car).espflash
		


func _sistem_spown(key_spown):
	#######posicion de camera: 
	if key_spown == 1:
		get_parent().get_node("cam_chase")._spowner(Vector3(0,180,0),get_parent().get_node("Check_spown/1").translation)
		get_parent().get_node("car").translation = get_parent().get_node("Check_spown/1").translation
		get_parent().get_node("car").rotation_degrees = Vector3(0,110,0)
	elif key_spown ==2:
		get_parent().get_node("car").translation = get_parent().get_node("Check_spown/2").translation
		get_parent().get_node("car").rotation_degrees = Vector3(0,180,0)
	pass

func _on_spown_sistem_colide_spown_limit(): ##### aqui poner llave de spown, 1,2,3,4,5,6 etc... 
	get_parent().get_node("car").linear_velocity = Vector3()
	get_parent().get_node("car").rpm = get_parent().get_node("car").IdleRPM
	### aqui se llama la funcion _
	_sistem_spown(Key_spowner)
	pass # Replace with function body.


func _on_car_Spown_system():
	get_parent().get_node("car").translation = get_parent().get_node("Point_Spown").translation
	get_parent().get_node("car").rotation = get_parent().get_node("Point_Spown").rotation
	
	####### anim_dark
	get_parent().get_node("cam_chase/orbit").rotation_degrees.z = 0
	get_parent().get_node("cam_chase").global_translation = get_parent().get_node("Point_Spown/Cam_position").global_translation
	
	pass


func portal_logic_sysrtem(numero_portal):
	get_parent().get_node("Levels/0/Label3D").text = "XXXX"
	get_parent().get_node("Levels/1/Label3D").text = "XXXX"
	get_parent().get_node("Levels/2/Label3D").text = "XXXX"
	get_parent().get_node("Levels/3/Label3D").text = "XXXX"
	get_parent().get_node("Levels/4/Label3D").text = "XXXX"
	if numero_portal== 0:
		get_parent().get_node("Levels/0/Label3D").text = "Rally_1"
	if numero_portal == 1: 
		get_parent().get_node("Levels/0/Label3D").text = "Rally_1"
		get_parent().get_node("Levels/1/Label3D").text = "Rally_2"
	if numero_portal == 2:
		get_parent().get_node("Levels/0/Label3D").text = "Rally_1"
		get_parent().get_node("Levels/1/Label3D").text = "Rally_2"
		get_parent().get_node("Levels/2/Label3D").text = "Rally_3"
	if numero_portal== 3: 
		get_parent().get_node("Levels/0/Label3D").text = "Rally_1"
		get_parent().get_node("Levels/1/Label3D").text = "Rally_2"
		get_parent().get_node("Levels/2/Label3D").text = "Rally_3"
		get_parent().get_node("Levels/3/Label3D").text = "Rally_4"
	if numero_portal ==4: 
		get_parent().get_node("Levels/0/Label3D").text = "Rally_1"
		get_parent().get_node("Levels/1/Label3D").text = "Rally_2"
		get_parent().get_node("Levels/2/Label3D").text = "Rally_3"
		get_parent().get_node("Levels/3/Label3D").text = "Rally_4"
		get_parent().get_node("Levels/4/Label3D").text = "Rally_5"
	pass


func _on_0_body_entered(body):  #### Auto_entra portal: 
	logic_portals_0 = true
	get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play("up")
	get_parent().get_node("debug/Texto_niveles/pop_up").play()
	pass # Replace with function body.


func _on_0_body_exited(body):   ##### Auto_sallida portal: 
	logic_portals_0 = false
	get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play_backwards("up")
	pass # Replace with function body.


func _on_Next_animation_finished(anim_name):
	if logic_portals_0 == true:
		get_tree().change_scene("res://scenes/Motor_selection/Motor_map_seletion.tscn")
	if casa == true: 
		get_tree().change_scene("res://scenes/Niveles/Niveles_prototipo.tscn")
		get_tree().paused = false
	if logic_portals_1 == true: 
		get_tree().change_scene("res://scenes/Motor_selection_2/Mpa_motor_Rally_2.tscn")
	if logic_portals_2 == true: 
		get_tree().change_scene("res://scenes/Motor_selection_3/Mpa_motor_Rally_2.tscn")
	if logic_portals_3 == true: 
		get_tree().change_scene("res://scenes/Motor_selection_4/Mpa_motor_Rally_2.tscn")
	if logic_portals_4 == true: 
		get_tree().change_scene("res://scenes/Motor_selection_5/Mpa_motor_Rally_2.tscn")
	pass # Replace with function body.


func _on_Back_home_Ajistes_pressed():
	pause_game = true
	$Pause/presed.play()
	$Pause.visible = true
	$Back_home_Ajistes.visible = false
	get_tree().paused = true
	pass # Replace with function body.

func _on_Reanudar_pressed():
	pause_game = false
	$Pause/presed.play()
	$Pause.visible = false
	get_tree().paused = false
	$Back_home_Ajistes.visible = true
	pass # Replace with function body.


func _on_Back_home_Ajistes_mouse_entered():
	$Pause/hover.play()
	pass # Replace with function body.


func _on_Reanudar_mouse_entered():
	$Pause/hover.play()
	pass # Replace with function body.


func _on_back_home_pressed():
	$Pause/presed.play()
	casa = true
	$Pause.visible = false
	$Texto_niveles/Next.play("Next_scene")
	pass # Replace with function body.


func _on_back_home_mouse_entered():
	$Pause/hover.play()
	pass # Replace with function body.




func _on_1_body_entered(body):
	if Pendiente.portales_secuancia_logica > 0:
		logic_portals_1 = true
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play("up")
		get_parent().get_node("debug/Texto_niveles/pop_up").play()
	pass # Replace with function body.


func _on_1_body_exited(body):
	if Pendiente.portales_secuancia_logica > 0:
		logic_portals_1 = false
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play_backwards("up")
	pass # Replace with function body.


func _on_2_body_entered(body):
	if Pendiente.portales_secuancia_logica > 1:
		logic_portals_2 = true
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play("up")
		get_parent().get_node("debug/Texto_niveles/pop_up").play()
	pass # Replace with function body.


func _on_2_body_exited(body):
	if Pendiente.portales_secuancia_logica > 1:
		logic_portals_2 = false
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play_backwards("up")
	pass # Replace with function body.


func _on_3_body_entered(body):
	if Pendiente.portales_secuancia_logica > 2:
		logic_portals_3 = true
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play("up")
		get_parent().get_node("debug/Texto_niveles/pop_up").play()
	pass # Replace with function body.


func _on_3_body_exited(body):
	if Pendiente.portales_secuancia_logica > 2:
		logic_portals_3 = false
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play_backwards("up")
	pass # Replace with function body.


func _on_4_body_entered(body):
	if Pendiente.portales_secuancia_logica > 3:
		logic_portals_4 = true
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play("up")
		get_parent().get_node("debug/Texto_niveles/pop_up").play()
	pass # Replace with function body.


func _on_4_body_exited(body):
	if Pendiente.portales_secuancia_logica > 3:
		logic_portals_4 = false
		get_parent().get_node("debug/Texto_niveles/pop_up_Animation").play_backwards("up")
	pass # Replace with function body.

extends Control


#######
var minutos = 0
var seg = 0
var start_timer = false

var lista_position_gosh = []

var changed_graph_size = Vector2(0,0)
export(NodePath) var car

var next = 0

func _ready():
	OS.center_window()
	get_parent().get_node("Back_gound_2D/AnimationPlayer").play("Aparecer")
	############
	if not car == "":
		
		for d in get_node(car).get_children():
			if "TyreSettings" in d:
				$vgs.append_wheel(d.translation,d.TyreSettings,d)
		
		for i in $power_graph.get_script().get_script_property_list():
			if not i["name"] == "peakhp" and not i["name"] == "tr" and not i["name"] == "tr" and not i["name"] == "hp" and not i["name"] == "skip" and not i["name"] == "scale":
				if i["name"] in get_node(car):
					$power_graph.set(i["name"], get_node(car).get(i["name"]))

func _process(delta):
	#if lista_position_gosh.size() == 2:
		#lista_position_gosh.remove(0)
	#lista_position_gosh.append(get_parent().get_node("Path/PathFollow").translation)
	#var distance_gosh = sqrt(pow(lista_position_gosh[-1][0]-lista_position_gosh[0][0],2)+pow(lista_position_gosh[-1][1]-lista_position_gosh[0][1],2)+pow(lista_position_gosh[-1][2]-lista_position_gosh[0][2],2))
	#var veloci_gosh = distance_gosh/delta
	#$Viewport2/Control.speed_Gosh = veloci_gosh
	#$Viewport2/Control.speed_Gosh = get_parent().get_node("car2").linear_velocity.length()*1.10130592
	#calculo_de_distancia(lista_position_gosh[0],lista_position_gosh[-1])
	#$Viewport/Positiont_ime.speed = get_node(car).linear_velocity.length()*1.10130592
	#$Viewport2/Control.speed = get_node(car).linear_velocity.length()*1.10130592
	#$Viewport3/Aceleration.speed = get_node(car).linear_velocity.length()*1.10130592
	
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
		


func _on_Area_body_entered(body):
	start_timer = true
	pass # Replace with function body.


func _on_Area2_body_entered(body):
	start_timer = false
	pass # Replace with function body.


func _on_cortina_animation_finished(anim_name):
	Pendiente.progress = 2
	get_tree().change_scene("res://scenes/Niveles/Niveles_prototipo.tscn")
	pass # Replace with function body.


func _on_Llegada_body_entered(body):
	$cortina.play_backwards("Intro_exit")
	pass # Replace with function body.




func _on_NEXT_pressed():
	next +=1
	if next ==1:
		$Dialogo/AnimationPlayer.play("esconder_change")
	elif next ==2: 
		$Dialogo/AnimationPlayer.play("salir")
	pass # Replace with function body.


func _on_Area3_body_entered(body):
	get_tree().change_scene("res://scenes/nivel_1_mapa_1/Nivel_1/world.tscn")
	pass # Replace with function body.

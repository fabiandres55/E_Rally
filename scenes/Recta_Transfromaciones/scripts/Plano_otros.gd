extends Control


var post_llegada = Vector2()
var post_inicio = Vector2()

var post_llegada_verif = Vector2(0,0) 
var post_incio_verif = Vector2(0,0) 

######### variable de desaparecer intercepto: 
export var show_inter  = false
export var dialog_secuence_plano = 9


func _ready():
	if show_inter == false:
		$Interacccion/salida_y.visible = false
	else:
		$Interacccion/salida_y.visible = true
	pass

func calculo_de_la_funcion(p_1:Vector2,p_2:Vector2):
	var m = (p_1.y-p_2.y)/(p_1.x-p_2.x)
	var b = p_2.y
	var poos_limite_infe = Vector2(-2000,-2000*m+b)
	var poos_limite_sup = Vector2( 2000,2000*m+b)
	###### dibujando la recta: 
	$Control/Line2D.add_point(poos_limite_infe)
	$Control/Line2D.add_point(poos_limite_sup)
	###### poscion del auto en la recta y grados de inclinacion.: 
	var grados_incli = rad2deg(atan(m)) 
	$Control/origen/car.rotation_degrees = grados_incli
	var pos_auto = Vector2((p_1.x-p_2.x)/2,((p_1.x-p_2.x)/2)*m+b)
	$Control/origen/car.position = pos_auto
	######## Lable de los puntos de llegada y salida: 
	$Control/origen/Inicio/Label.text = "Inicio ({x},{y})".format({"x":str(0),"y":str($Interacccion/salida_y.value)})
	$Control/origen/Llegada/Label.text = "llegada ({x},{y})".format({"x":$Interacccion/Llegada_X.value,"y":str($Interacccion/Llegada_Y.value)})
	###### añadiendo componenetes del punto de llegada, salida: 
	$Control/llegada_x.add_point(Vector2($Control/origen/Llegada.position.x,0))
	$Control/llegada_x.add_point(Vector2($Control/origen/Llegada.position.x,$Control/origen/Llegada.position.y))
	$Control/llegada_x.add_point(Vector2(0,$Control/origen/Llegada.position.y))
	##### añadiendo label a la pendiente: 
	$Interacccion/Pendiente_show/y_2.text = str($Interacccion/Llegada_Y.value)
	$Interacccion/Pendiente_show/y_1.text = str($Interacccion/salida_y.value)
	$Interacccion/Pendiente_show/x_2.text = str($Interacccion/Llegada_X.value)
	#
	var pendi = ($Interacccion/Llegada_Y.value-$Interacccion/salida_y.value)/($Control/origen/Llegada.position.x-0)
	$Interacccion/Pendiente_show/result.text = str(pendi)
	# polinomio;show:
	$Interacccion/Pendiente_show/result_poli.text = str(pendi)+"x + "+str($Interacccion/salida_y.value)
	
	
	pass


func show_caracteris_guion(num): ### num: 9,10,11...etc
	$Control/llegada_x.visible = false
	$Control/Line2D.visible = false
	$Control/origen.visible = false
	$Interacccion.visible = false
	$Control/origen/Inicio.visible = false
	$Control/origen/Llegada.visible = false
	$Control/origen/car.visible = false
	$Imagen_text.visible = false
	$Plano.visible = false
	if num == 9:
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = false
	if  num == 10 or num == 11:
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = true
	if num == 12 or num == 13:
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = true
		$Control/origen/Llegada.visible = true
	if num == 14:
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = true
		$Control/origen/Llegada.visible = true
		$Control/Line2D.visible = true
	if num == 17:
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = true
		$Control/origen/Llegada.visible = true
		$Control/Line2D.visible = true
		$Control/llegada_x.visible = true
	if num == 18:
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = true
		$Control/origen/Llegada.visible = true
		$Control/Line2D.visible = true
		$Control/llegada_x.visible = true
		$Interacccion.visible = true
	if num == 21: 
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		#$Control/origen/Llegada/Label.visible = false
	if num == 22: 
		$Plano.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Imagen_text.visible = true
	if num == 26:
		$Plano.visible = true
		$Control/origen/car.visible = true
		$Control/origen.visible = true
		$Control/origen/Inicio.visible = true
		$Control/origen/Inicio/Label.visible = true
		$Control/origen/Llegada.visible = true
		$Control/Line2D.visible = true
		$Control/llegada_x.visible = true
		$Interacccion.visible = true
		$Imagen_text.visible = true
	pass

func _process(delta):
	####### se muestra secuancia del guion:
	#show_caracteris_guion(dialog_secuence_plano)
	
	###### se muestra o no el intercepto:
	if show_inter == false:
		$Interacccion/salida_y.visible = false
	else:
		$Interacccion/salida_y.visible = true
	
	######## aqui declaro laposiciond e llegada y salida. 
	post_llegada = Vector2($Interacccion/Llegada_X.value,-1*$Interacccion/Llegada_Y.value)
	post_inicio =  Vector2(0,-1*$Interacccion/salida_y.value)
	######## aqui determino el cambio de psoicion: 
	if post_llegada != post_llegada_verif  or post_inicio != post_incio_verif: 
		$Control/Line2D.clear_points()
		$Control/llegada_x.clear_points()
		post_incio_verif = post_inicio
		post_llegada_verif = post_llegada
		calculo_de_la_funcion(post_llegada,post_inicio) ##### llamo la funcion, pasando los parametros de la misma. 
	############### posicion del punto en la posicion: 
	$Control/origen/Llegada.position = post_llegada
	$Control/origen/Inicio.position = post_inicio
	################# texto de la posicion: 
	$Interacccion/Llegada_X/Label.text = "llegada.x: "+ str(post_llegada.x)
	$Interacccion/Llegada_Y/Label.text = "llegada.y: "+ str(-1*post_llegada.y)
	$Interacccion/salida_y/Label.text = "salida.y: "+ str(-1*post_inicio.y)
	pass

extends Control


export var p_llegada_x = 0
export var p_llegada_y = 0

var p_llegada_verifica_x = 0   
var p_llegada_verifica_y = 0 

export var p_Inicio_y = 0   ##### aqui hay un prblema de escala cunado llegada>500. inicio=500 incio>llegada. cosa seria falsa :-(
export var p_Inicio_x = 0


var p_Inicio_verif = 0


func calculo_de_la_funcion(p_1:Vector2,p_2:Vector2):
	var m = (p_1.y-p_2.y)/(p_1.x-p_2.x)
	var b = p_2.y
	var poos_limite_infe = Vector2(-900,-900*m+b)
	var poos_limite_sup = Vector2( 1000,1000*m+b)
	###### dibujando la funcion:
	$Lines/Line_funtion.add_point(poos_limite_infe)
	$Lines/Line_funtion.add_point(poos_limite_sup)
	###### dibujando la recta solo dos puntos:
	$Lines/Line_2puntos.add_point($Puntos/Origen/P_Inicio.position)
	$Lines/Line_2puntos.add_point($Puntos/Origen/P_Llegada.position)

func Escala_mapa(llegada_x,llegada_y):
	
	if abs(llegada_x)<=10:#### 100*x
		llegada_x =  100*llegada_x
	elif abs(llegada_x)<=100:  ##### 10*X
		llegada_x = 10*llegada_x
	elif abs(llegada_x)<=1000: ###### Aaqui no hay problema 
		llegada_x = llegada_x
	elif abs(llegada_x) <=10000:##### y= x/10
		llegada_x = llegada_x/10
	elif abs(llegada_x)<=100000: ##### y= x/100
		llegada_x = llegada_x/100
	############################Componente Horizontal.. solo hasta escala 100000
	if abs(llegada_y)<=50:#### 10*x metros
		llegada_y =  10*llegada_y
	elif abs(llegada_y)<=100:  ##### 5*X
		llegada_y = 5*llegada_y
	elif abs(llegada_y)<=500:  ##### Nomal
		llegada_y = llegada_y
	elif abs(llegada_y)<=1000:  ##### X*0.5
		llegada_y = 0.5*llegada_y
	elif abs(llegada_y)<=5000:  ##### X*0.1
		llegada_y = 0.1*llegada_y
	######### Retorna valores.....
	return Vector2(llegada_x,-1*llegada_y)
	

func _process(delta):
	if p_llegada_x != p_llegada_verifica_x or p_llegada_y != p_llegada_verifica_y or p_Inicio_y != p_Inicio_verif :
		p_llegada_verifica_x = p_llegada_x
		p_llegada_verifica_y = p_llegada_y
		p_Inicio_verif = p_Inicio_y
		##################################
		var pos_escala = Escala_mapa(p_llegada_x,p_llegada_y)
		
		###### Compoenente Llegada:
		$Puntos/Origen/P_Llegada.position = Vector2(pos_escala)
		$Puntos/Origen/P_Llegada/Label.text = "Llegada({v-1},{v-2})".format({"v-1":p_llegada_x,"v-2":p_llegada_y})
		#######componenteInicio:
		pos_escala = Escala_mapa(p_Inicio_x,p_Inicio_y)
		$Puntos/Origen/P_Inicio.position = Vector2(pos_escala)
		$Puntos/Origen/P_Inicio/Label.text = "Inicio({v-1},{v-2})".format({"v-1":p_Inicio_x,"v-2":p_Inicio_y})
		calculo_de_la_funcion($Puntos/Origen/P_Llegada.position,$Puntos/Origen/P_Inicio.position)
		
	pass

func _ready():
	pass






extends Control



func _trayectoria_funcion_particula(x,y):
	$Bola.position = Vector2(x,-1*y)
	$trayecto.add_point($Bola.position,-1)
	pass

func _punto_position(dominio,rango):
	$Punto_.position = Vector2(dominio,-1*rango)
	$Punto_/Label.text = "({x}, {y})".format({"x":dominio/1000,"y":round(rango)})
	pass

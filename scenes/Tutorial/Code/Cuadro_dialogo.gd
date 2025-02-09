extends CanvasLayer



var numero_text = 0
var antecesor_numero_texto = numero_text


func _process(delta):
	$Imagenes_explicacion/Des_lizador_pendiente/ColorRect.rect_rotation = -1*$Imagenes_explicacion/Des_lizador_pendiente/HSlider.value
	pass

var Exit = false

var texto = {
	0:"Leonhard: ¡Hola, piloto! estoy aquí para guiarte en esta emocionante aventura llamada E_Rally. En este tutorial, te explicaré de manera sencilla cómo entender el concepto de pendiente de una función lineal usando la inclinación de la pista mientras conduces a toda velocidad.",
	1:"Leonhard: Imagina que estás manejando por una carretera en E_Rally.",
	2:"Leonhard: ¡No! esa no...",
	3:"Leonhard: Está mucho mejor ahora. Y de repente notas que la pista se inclina hacia arriba o hacia abajo. Puedes hacer que se incline con el deslizador en la parte superior izquierda.",
	4:"Leonhard: ¡Esa inclinación es lo que se llama pendiente! Ahora, escuche bien: la pendiente te dice cuánto cambia la altura de la pista en relación con la distancia que avanzas horizontalmente.",
	5:"Leonhard: Leonhard: Un ejemplo es el siguiente. Aquí puedes notar que cuando avanzas horizontalmente 1 metro, también avanzas verticalmente 1 metro. Este tipo de función se llama función IDENTIDAD.",
	6:"Leonhard: Pero no todas las funciones lineales son así. Te voy a mostrar un ejemplo.",
	7:"Leonhard: Así como en la pista te puedes  encontrar con tramos de ascenso; también hay tramos de descenso; Es decir, mientras más te desplaces horizontalmente, vas perdiendo altura.",
	8:"Leonhard: Hasta aquí, has aprendido lo básico sobre pendientes. Pero para ganar en una carrera, necesitas saber la pendiente de la pista y elegir el motor adecuado.",
	9:"Leonhard: Para determinar la pendiente de la pista, es necesario tener dos datos importantes: la posición de salida  y la posición de llegada. Este punto rojo representa la posición de salida.",
	10:"Leonhard: Como puedes ver, este punto tiene características especiales. La primera es que su posición horizontal hace referencia a la distancia, mientras que la posición vertical hace referencia a la distancia vertical (altura).",
	11:"Leonhard: Como este punto rojo representa tu posición de salida en la carrera, entonces tu distancia y altura son cero.",
	12:"Leonhard: Ahora tienes este punto azul en pantalla, este representa la posición de llegada de la carrera!",
	13:"Leonhard: Este punto azul representa tu posición de llegada. Tu distancia y altura son distintas de cero. A medida que te acerques a este punto, irás ganando distancia y altura.",
	14:"Leonhard: ¡Ahora une  estos dos puntos mediante una línea recta!",
	15:"Leonhard: Tantan! ¡Esta es una función lineal!",
	16:"Leonhard: Pero…¿sabemos cuál es su pendiente?",
	17:"Leonhard: Si encuentras la distancia total que avanzaste horizontalmente y vertical, además dividimos la distancia vertical entre la horizontal, esta sería la pendiente de tu recta. Que la representaremos por la letra m.",
	18:"Leonhard: Ahora ¿qué pasaría con la pendiente si cambiamos la posición de llegada? puedes cambiar con los  deslizadores en la parte superior izquierda.",
	19:"Leonhard: Hasta aquí  esto sería todo en términos prácticos lo que representa la pendiente.",
	20:"Leonhard: Ahora te voy a mostrar lo que representa el intercepto de una función lineal aplicado a las pistas de automovilismo !",
	21:"Leonhard: Mira, este punto rojo es tu punto de partida en la carrera, y está lógicamente en la posición horizontal 0, ya que avanzarás en distancia durante la competencia.",
	22:"Leonhard: Te preguntarás qué significa su posición vertical. Esto representa tu altura en el punto de partida, es decir, en este caso, tu altura de salida es a nivel del mar.",
	23:"Leonhard: Lo que intento explicarte es que si empiezas desde una posición vertical muy alta, tu altura será considerable, pero tu desplazamiento siempre será 0, ya que es el punto de partida de la carrera.",
	24:"Leonhard: Siguiendo este razonamiento, el intercepto representa tu posición vertical de partida en la carrera; Vamos a simbolizarlo con la letra b. Este valor es relevante, ya que si tu posición vertical es significativamente alta, necesitaríamos realizar adaptaciones en el vehículo.",
	25:"Leonhard: Y listo ya tienes idea de que es el intercepto.",
	26:"Leonhard: Ahora ¿qué pasaría con la pendiente si cambiamos la posición de llegada y salida?puedes cambiar las posiciones  con el deslizador en la parte superior izquierda. matemáticamnete hablando la recta tiene la siguiente notación: y = mx+b", ##### ver los DBA para notar de mejor forma. 
	27:"Leonhard: Eso sería todo por el momento piloto! Nos vemos en la pista de carreras!"
}


func _Animation(numero):#### numero = 1 Enter , numero = 0 Exit
	if numero == 1:
		$Up_Down.play_backwards("Enter_exit")
	else: 
		$Up_Down.play("Enter_exit")



# Called when the node enters the scene tree for the first time.
func _ready():
	_Animation(1)
	pass # Replace with function body.

func _show_text(numero_dialogo):
	
	$Next/up_button.play_backwards("up")
	$Sounds/Key_board_sound.play()
	if numero_dialogo<=27 and 0<=numero_dialogo:
		$Label.text = texto[numero_dialogo]
	
	if numero_text-antecesor_numero_texto != -1: ###### va creciendo  menos a mas! 
		print("pa adelante")
		if numero_dialogo == 1:                     
		#$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_0")
			pass
		elif numero_dialogo ==2: 
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_0")
		elif numero_dialogo == 3:
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_1")
		elif numero_dialogo ==4:
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_2")
		elif numero_dialogo ==5: 
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_4")
		elif numero_dialogo ==6:
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_4")
		elif numero_dialogo ==7:
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_5")
		elif numero_dialogo ==8:
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_5")
		elif numero_dialogo == 9:
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_18")
			$Control.show_caracteris_guion(9)
			pass
		elif numero_dialogo == 10:
			$Control.show_caracteris_guion(10)
			pass
		elif numero_dialogo == 11:
			$Control.show_caracteris_guion(11)
			pass
		elif numero_dialogo == 12:
			$Control.show_caracteris_guion(12)
			pass
		elif numero_dialogo == 13:
			$Control.show_caracteris_guion(13)
			pass
		elif numero_dialogo == 14:
			$Control.show_caracteris_guion(14)
			pass
		elif numero_dialogo == 15:
			pass
		elif numero_dialogo == 16:
			pass
		elif numero_dialogo == 17:
			$Control.show_caracteris_guion(17)
			pass
		elif numero_dialogo == 18:
			$Control.show_caracteris_guion(18)
			$Control.show_inter = false
		elif numero_dialogo == 19:
			$Control.show_caracteris_guion(19)
			pass
		elif numero_dialogo == 20:
			pass
		elif numero_dialogo == 21:
			$Control.show_caracteris_guion(21)
			pass
		elif numero_dialogo == 22:
			$Control.show_caracteris_guion(22)
			pass
		elif numero_dialogo == 23:
			pass
		elif numero_dialogo == 24:
			pass
		elif numero_dialogo == 25:
			pass
		elif numero_dialogo == 26:
			$Control.show_caracteris_guion(26)
			$Control.show_inter = true
		elif numero_dialogo == 27:
			$Control.show_caracteris_guion(27)
		elif numero_dialogo >27:
			_Animation(0)
			Exit = true
		
	if numero_text-antecesor_numero_texto == -1: ###### va creciendo  menos a mas! 
		print("pa atras")
		if numero_dialogo ==1: 
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_0")
		elif numero_dialogo == 2:
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_1")
		elif numero_dialogo ==3:
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_2")
		elif numero_dialogo ==4: 
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_4")
		elif numero_dialogo ==5:
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_4")
		elif numero_dialogo ==6:
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_5")
		elif numero_dialogo ==7:
			$Imagenes_explicacion/Animaciones_explicaciones.play("Animacion_5")
		elif numero_dialogo == 8:
			$Imagenes_explicacion/Animaciones_explicaciones.play_backwards("Animacion_18")
			$Control.show_caracteris_guion(8)
			pass
		elif numero_dialogo == 9:
			$Control.show_caracteris_guion(9)
			pass
		elif numero_dialogo == 10:
			$Control.show_caracteris_guion(10)
			pass
		elif numero_dialogo == 11:
			$Control.show_caracteris_guion(11)
			pass
		elif numero_dialogo == 12:
			$Control.show_caracteris_guion(12)
			pass
		elif numero_dialogo == 13:
			$Control.show_caracteris_guion(13)
			pass
		elif numero_dialogo == 14:
			pass
		elif numero_dialogo == 15:
			pass
		elif numero_dialogo == 16:
			$Control.show_caracteris_guion(16)
			pass
		elif numero_dialogo == 17:
			$Control.show_caracteris_guion(17)
			$Control.show_inter = false
		elif numero_dialogo == 18:
			$Control.show_caracteris_guion(18)
			pass
		elif numero_dialogo == 19:
			pass
		elif numero_dialogo == 20:
			$Control.show_caracteris_guion(20)
			pass
		elif numero_dialogo == 21:
			$Control.show_caracteris_guion(21)
			pass
		elif numero_dialogo == 22:
			pass
		elif numero_dialogo == 23:
			pass
		elif numero_dialogo == 24:
			pass
		elif numero_dialogo == 25:
			$Control.show_caracteris_guion(22)
			$Control.show_inter = false
		elif numero_dialogo == 26:
			$Control.show_caracteris_guion(26)
		elif numero_dialogo<0:
			_Animation(0)
			Exit = true
		pass
	$Texto.play("Texto")
	


func _on_Intro_0_finished():
	$Next/up_button.play("up")
	$Next/up.play()
	pass # Replace with function body.


func _on_Next_mouse_entered():
	$Next/Hover_.play()
	pass # Replace with function body.


func _on_Next_pressed():   # aqui tengo que añadir el dialogo que se va mostrando en funcion a los next
	$Next/Enter.play()
	if numero_text <=27: ### numero totales de guion 
		antecesor_numero_texto = numero_text
		numero_text += 1
		_show_text(numero_text)
	
		
	pass # Replace with function body.

func _on_Up_Down_animation_finished(anim_name):
	_show_text(numero_text)
	if Exit == true:
		if numero_text>27 and Pendiente.progress ==0:
			Pendiente.progress = 1
		get_tree().change_scene("res://scenes/Niveles/Niveles_prototipo.tscn")
	pass # Replace with function body.
func _on_Texto_animation_finished(anim_name):
	$Sounds/Key_board_sound.stop()
	pass # Replace with function body.

func _on_Back_pressed():
	if numero_text>=0:
		antecesor_numero_texto = numero_text
		numero_text -= 1
		_show_text(numero_text)
		
	pass # Replace with function body.

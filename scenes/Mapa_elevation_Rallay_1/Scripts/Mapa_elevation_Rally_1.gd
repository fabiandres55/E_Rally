extends Control


var valor_entrada
var Error = false
var Next_scene = false
var Back_scene = false

func _ready():
	$Plano.p_llegada_x = 7030
	$Plano.p_llegada_y = 611
	$Input/Correcto.visible = false
	$Input/Error.visible = false
	$Information.visible = false
	$vamos.visible = false
	$Buttons/Con/Go.visible = false
	pass

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
			if $Input/LineEdit.text.is_valid_float():
				valor_entrada = float($Input/LineEdit.text)
				aviso_Error(false)
				$Input/Correcto.text = "La pendiente que calculaste es: " + str(valor_entrada) + " Lo tengo."
				$Input/LineEdit.clear()
				$Buttons/Con/Go.visible = true
			else: 
				Error = true
				aviso_Error(true)
				$Input/LineEdit.clear()
	pass

func _Window(valor):# valor: 0 Infromacion, 1:Mapa, 2, Vamos..
	$Texto.visible = false
	$Input.visible = false
	$Plano.visible = false
	$ColorRect.visible = false
	$Information.visible = false
	$vamos.visible = false
	if valor == 1:
		$Texto.visible = true
		$Input.visible = true
		$Plano.visible = true
		$ColorRect.visible = true
	elif valor ==0:
		$Information.visible = true
	elif valor ==2:
		$vamos.visible = true

func _on_Info_pressed():
	_Window(0)
	pass # Replace with function body.


func _on_Map_pressed():
	_Window(1)
	pass # Replace with function body.

func _on_Go_pressed():
	_Window(2)
	if valor_entrada == 0.0869 or valor_entrada == 0.08 or valor_entrada == 0.086 or valor_entrada == 0.08691:
		$vamos/text.text = "Buen trabajo, nuestro mecánico nos dice que tus cálculos estan bien."
		$vamos/Next_scene.visible = true
	else: 
		$vamos/text.text = "Nuestro mecánico encuentra algo sospechosa tu respuesta. Intentalo de nuevo :-) "
		$vamos/Next_scene.visible = false
	pass # Replace with function body.


func _on_Next_scene_pressed():
	$cortina.play_backwards("Intro_exit")
	Next_scene = true
	pass # Replace with function body.


func _on_cortina_animation_finished(anim_name):
	if Next_scene == true:
		get_tree().change_scene("res://scenes/nivel_1_mapa_1/Nivel_1/world.tscn")
		Next_scene = false
	if Back_scene == true:
		get_tree().change_scene("res://scenes/Niveles/Niveles_prototipo.tscn")
		Back_scene = true
	pass # Replace with function body.


func _on_Exit_pressed():
	$cortina.play_backwards("Intro_exit")
	Back_scene = true
	pass # Replace with function body.

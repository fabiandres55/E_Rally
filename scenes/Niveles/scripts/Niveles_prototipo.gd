extends Control


var numero = 1 ##### este establece si es exit, o enter 
var scena  # 0 menu, 1 intro, 2 rally1, 3 rally 2

##########
var Next_scene = false
var Next_scene_2 = false

var x = 0

var dibujo = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AudioStreamPlayer.play(Pendiente.Audio_time+0.1)
	#_Animation(numero)
	if Pendiente.progress == 0:
		$Buttons_/HBoxContainer/Rally_1.disabled = true
		$Buttons_/HBoxContainer/Rally_2.disabled = true
		pass
	elif Pendiente.progress == 1:
		$Buttons_/HBoxContainer/Rally_1.disabled = false
		$Buttons_/HBoxContainer/Rally_2.disabled = true
		pass
	else: 
		$Buttons_/HBoxContainer/Rally_1.disabled = false
		$Buttons_/HBoxContainer/Rally_2.disabled = false
	pass # Replace with function body.

func _Animation(numero):#### numero = 1 Enter , numero = 0 Exit
	if numero == 1:
		$Animations/Enter_Exit.play("Exit")
	else: 
		$Animations/Enter_Exit.play("Enter_exit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): ##### funcion que se ve en pantalla:
	
	if $Buttons_/HBoxContainer/Rally_2.disabled == true:
		$Buttons_/HBoxContainer/Rally_2/Clock.visible = false
		$Buttons_/HBoxContainer/Rally_2/Label.visible = false
	else: 
		$Buttons_/HBoxContainer/Rally_2/Clock.visible = true
		$Buttons_/HBoxContainer/Rally_2/Label.visible = true
	##################
	if $Buttons_/HBoxContainer/Rally_1.disabled == true:
		$Buttons_/HBoxContainer/Rally_1/Label.visible = false
	else: 
		$Buttons_/HBoxContainer/Rally_1/Label.visible = true
	##################
	x += delta*50
	###### aqui creo x y los valores de delta van a ser los parametros del dominio de la funcion. 
	if x<= 670:
		if dibujo == true:
			$Buttons_/Fondo_funcion/P.position = Vector2(x,funcion(x)[0])
			$Buttons_/Fondo_funcion/Line2D.add_point($Buttons_/Fondo_funcion/P.position)
			$Buttons_/Fondo_funcion/P_2.position = Vector2(x,funcion(x)[1])
			$Buttons_/Fondo_funcion/Line2D2.add_point($Buttons_/Fondo_funcion/P_2.position)
		else: 
			$Buttons_/Fondo_funcion/P.position = Vector2(x,funcion(x)[0])
			$Buttons_/Fondo_funcion/P_2.position = Vector2(x,funcion(x)[1])
	else: 
		dibujo = false
		x=0
	pass


func funcion(x):### aqui se desceribe la funcion:
	return [50*sin(x/15)+87,70*cos(x/15)+87]

func _on_Exit_pressed():
	numero = 0
	scena = 0
	emit_sound(1)
	Pendiente.Audio_time = $AudioStreamPlayer.get_playback_position()
	_Animation(numero)
	pass # Replace with function body.


func _on_Enter_Exit_animation_finished(anim_name):
	if scena == 0:
		get_tree().change_scene("res://scenes/Menu/Menu.tscn")
	elif scena == 1:
		get_tree().change_scene("res://scenes/Tutorial/Cuadro_dialogo.tscn")
	pass # Replace with function body.


func _on_Exit_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_Exit_mouse_exited():
	pass # Replace with function body.
	

func emit_sound(Hover_pressed): ##### Hover = 0, Pressed = 1
	if Hover_pressed == 0:
		$Sounds/Hover.play()
	if Hover_pressed == 1:
		$Sounds/play.play()


func _on_Intro_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_Intro_pressed():
	emit_sound(1)
	numero = 0
	scena = 1
	_Animation(numero)
	pass # Replace with function body.


func _on_Rally_1_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_Rally_1_pressed():
	emit_sound(1)
	$cortina.play_backwards("Intro_exit")
	Next_scene = true
	pass # Replace with function body.


func _on_Rally_2_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_Rally_2_pressed():
	emit_sound(1)
	$cortina.play_backwards("Intro_exit")
	Next_scene_2 = true
	pass # Replace with function body.


func _on_cortina_animation_finished(anim_name):
	if Next_scene == true: 
		Next_scene = false
		get_tree().change_scene("res://scenes/Mapa_elevation_Rallay_1/Mapa_elevation_Rally_1.tscn")
	elif Next_scene_2 == true:
		Next_scene_2 = false
		get_tree().change_scene("res://world.tscn")
	pass # Replace with function body.

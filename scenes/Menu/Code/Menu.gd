extends Control

var numero = 0  ###### aqui 0 sale y 1 entra 

var audio_time = 0
##################### variable de ajustes
var ajustes = false



func emit_sound(Hover_pressed): ##### Hover = 0, Pressed = 1
	if Hover_pressed == 0:
		$Node2D/Hover.play()
	if Hover_pressed == 1:
		$Node2D/Acept.play()

func _ready():
	$Ajustesyextras.visible = false
	
	
	#if Pendiente.Audio_time ==0:
		#$AudioStreamPlayer.play()
	#else: 
		#$AudioStreamPlayer.play(Pendiente.Audio_time+0.1)
	numero = 1
	_Animation_exit_enter(numero)

func _Animation_exit_enter(numero): ###### aqui 0 sale y 1 entra 
	if numero == 1:
		$Animations_/Play.play("Exit_levels")
	else: 
		$Animations_/Play.play("Play")

func _on_Exit_pressed():
	$Animations_/Exit.play("Exit")
	emit_sound(1)
	pass # Replace with function body.

func _on_No_pressed():
	$Animations_/Exit.play_backwards("Exit")
	emit_sound(1)
	pass # Replace with function body.


func _on_yes_pressed(): ##### cierre de programa...
	emit_sound(1)
	get_tree().quit()
	pass # Replace with function body.


############################### Hover de los Botones_-- play_exit
func _on_Exit_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.

func _on_Play_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_yes_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_No_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_Play_pressed():
	emit_sound(1)
	numero = 0
	Pendiente.Audio_time=$AudioStreamPlayer.get_playback_position()
	_Animation_exit_enter(numero)
	
	pass # Replace with function body.



func _on_Play_animation_finished(anim_name):
	if numero == 0:
		get_tree().change_scene("res://scenes/Niveles/Niveles_prototipo.tscn")
	pass # Replace with function body.


func _on_exit_Ajustes_pressed():
	emit_sound(1)
	ajustes = false
	$Ajustesyextras.visible = false
	$Buttons_Titles.visible = true
	pass # Replace with function body.


func _on_Credits_pressed():
	emit_sound(1)
	ajustes = true
	$Ajustesyextras.visible = true
	$Buttons_Titles.visible = false
	pass # Replace with function body.






func _on_Credits_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.


func _on_exit_Ajustes_mouse_entered():
	emit_sound(0)
	pass # Replace with function body.

extends Control

var currentrpm = 0.0
var currentpsi = 0.0

export var Turbo_Visible = false
export var Max_PSI = 13.0
export var RPM_Range = 9000.0
export var Redline = 7000.0

var generated = []

func _ready():
	$turbo.visible = Turbo_Visible
	$turbo/maxpsi.text = str(int(Max_PSI))
	if len(generated)>0:
		for i in generated:
			i.queue_free()
		generated.clear()
	
	var lowangle = -120
	var highangle = 120
	
	var maximum = int(RPM_Range/1000.0)
	var red = Redline/1000.0 -0.001
	
	for i in range(maximum+1):
		var dist = float(i)/float(maximum)
		var dist2 = (float(i)+0.25)/float(maximum)
		var dist3 = (float(i)+0.5)/float(maximum)
		var dist4 = (float(i)+0.75)/float(maximum)
		
		var d = $tacho/major.duplicate(true)
		$tacho.add_child(d)
		d.rect_rotation = lowangle*(1.0-dist) + highangle*dist
		d.visible = true
		d.get_node("tetx").text = str(i)
		d.get_node("tetx").rect_rotation = -d.rect_rotation
		generated.append(d)
		
		if float(i)>red:
			d.color = Color(1,0,0)
		
		if len(d.get_node("tetx").text)>1:
			d.get_node("tetx").rect_position.y += 5

		if not i == maximum:
			d = $tacho/minor.duplicate(true)
			$tacho.add_child(d)
			d.rect_rotation = lowangle*(1.0-dist2) + highangle*dist2
			d.visible = true
			generated.append(d)
			if float(i+0.25)>red:
				d.color = Color(1,0,0)

			d = $tacho/minor.duplicate(true)
			$tacho.add_child(d)
			d.rect_rotation = lowangle*(1.0-dist3) + highangle*dist3
			d.visible = true
			generated.append(d)
			if float(i+0.5)>red:
				d.color = Color(1,0,0)

			d = $tacho/minor.duplicate(true)
			$tacho.add_child(d)
			d.rect_rotation = lowangle*(1.0-dist4) + highangle*dist4
			d.visible = true
			generated.append(d)
			if float(i+0.75)>red:
				d.color = Color(1,0,0)

func _process(delta):
	$tacho/needle.rect_rotation = -120.0 +240.0*(abs(currentrpm)/RPM_Range)

	$turbo/needle.rect_rotation = -90.0 +180.0*(currentpsi/Max_PSI)
	
	if $turbo/needle.rect_rotation<-90.0:
		$turbo/needle.rect_rotation = -90.0

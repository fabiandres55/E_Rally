extends Spatial

export var WhinePitch = 4
export var WhineVolume = 0.4
 
export var BlowOffBounceSpeed = 0.0
export var BlowOffWhineReduction = 1.0
export var BlowDamping = 0.25
export var BlowOffVolume = 0.5
export var BlowOffVolume2 = 0.5
export var BlowOffPitch1 = 0.5
export var BlowOffPitch2 = 1.0
export var MaxWhinePitch = 1.8
export var SpoolVolume = 0.5
export var SpoolPitch = 1.1
export var BlowPitch = 1.0

export var volume = 0.25
var blow_psi = 0.0
var blow_inertia = 0.0


func play():
	$blow.stop()
	$spool.stop()
	$whistle.stop()
	$scwhine.stop()
	$whigh.play()
	$wlow.play()

	if get_parent().TurboEnabled:
		$blow.play()
		$spool.play()
		$whistle.play()
	if get_parent().SuperchargerEnabled:
		$scwhine.play()
			
func stop():
	for i in get_children():
		i.stop()

func _ready():
	play()

func _physics_process(delta):
	$scwhine.unit_db = linear2db(WhineVolume*volume)
	$scwhine.max_db = $scwhine.unit_db
	$scwhine.pitch_scale = abs(get_parent().rpm/10000.0)*WhinePitch


	var dist = blow_psi - get_parent().turbopsi
	blow_psi -= (blow_psi - get_parent().turbopsi)*BlowOffWhineReduction
	blow_inertia += blow_psi - get_parent().turbopsi
	blow_inertia -= (blow_inertia - (blow_psi - get_parent().turbopsi))*BlowDamping
	blow_psi -= blow_inertia*BlowOffBounceSpeed

	if blow_psi>get_parent().MaxPSI:
		blow_psi = get_parent().MaxPSI
		
		
	var blowvol = dist
	if blowvol<0.0:
		blowvol = 0.0
	elif blowvol>1.0:
		blowvol = 1.0
		
	var spoolvol = get_parent().turbopsi/10.0
	if spoolvol<0.0:
		spoolvol = 0.0
	elif spoolvol>1.0:
		spoolvol = 1.0

	

	var blow = linear2db(volume*(blowvol*BlowOffVolume2))
	if blow<-60.0:
		blow = -60.0
	var spool = linear2db(volume*(spoolvol*SpoolVolume))
	if spool<-60.0:
		spool = -60.0

	$blow.unit_db = blow
	$spool.unit_db = spool
	
	$blow.max_db = $blow.unit_db
	$spool.max_db = $spool.unit_db
	var yes = blowvol*BlowOffVolume
	if yes>1.0:
		yes = 1.0
	elif yes<0.0:
		yes = 0.0
	var whistle = linear2db(yes)
	if whistle<-60.0:
		whistle = -60.0
	$whistle.unit_db = whistle
	$whistle.max_db = $whistle.unit_db
	var wps = 1.0
	if get_parent().turbopsi>0.0:
		wps = blowvol*BlowOffPitch2 +get_parent().turbopsi*0.05 +BlowOffPitch1
	else:
		wps = blowvol*BlowOffPitch2 +BlowOffPitch1
	if wps>MaxWhinePitch:
		wps = MaxWhinePitch
	$whistle.pitch_scale = wps
	$spool.pitch_scale = SpoolPitch +spoolvol*0.5
	$blow.pitch_scale = BlowPitch


	var h = get_parent().whinepitch/200.0
	if h>1.0:
		h = 1.0
	elif h<0.5:
		h = 0.5
		
	var wlow = linear2db(((get_parent().gearstress*get_parent().GearGap)/160000.0)*((1.0-h)*0.5))
	if wlow<-60.0:
		wlow = -60.0
	$wlow.unit_db = wlow
	$wlow.max_db = $wlow.unit_db
	$wlow.pitch_scale = get_parent().whinepitch/50.0
	var whigh = linear2db(((get_parent().gearstress*get_parent().GearGap)/80000.0)*0.5)
	if whigh<-60.0:
		whigh = -60.0
	$whigh.unit_db = whigh
	$whigh.max_db = $whigh.unit_db
	$whigh.pitch_scale = get_parent().whinepitch/100.0






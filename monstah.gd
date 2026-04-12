extends CharacterBody2D

var kecepatan = 60 #m/s
var arah =  -1
const BOUNCE_FORCE = -600.0

@onready var ray_cast_kanan: RayCast2D = $RayCastKanan
@onready var ray_cast_kiri: RayCast2D = $RayCastKiri
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func play_stun():
	animated_sprite.play("stun")
	timer.start()
	
func _process(delta):
	if ray_cast_kanan.is_colliding():
		arah = -1
		animated_sprite.flip_h = false
		animated_sprite.play("run")
		
	if ray_cast_kiri.is_colliding():
		arah = 1
		animated_sprite.flip_h = true
		animated_sprite.play("run")
		
	position.x += arah * kecepatan * delta
	
func _on_timer_timeout() -> void:
	kecepatan = 0
	pass # Replace with function body.

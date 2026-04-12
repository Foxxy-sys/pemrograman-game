extends CharacterBody2D

class_name Jamur_Terbang

const speed = 40
var dir: Vector2

var is_Jamur_chase: bool

var player: CharacterBody2D

func _ready():
	is_Jamur_chase = true
	
func _process(delta):
	move(delta)
	animasi()
	
func move(delta):
	if is_Jamur_chase:
		player = Global.pleyah
		velocity = position.direction_to(player.position) * speed
		dir.x = abs(velocity.x) / velocity.x
	elif !is_Jamur_chase:
		velocity += dir * speed * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_Jamur_chase:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		print(dir)
	
func animasi():
	var movement = $AnimatedSprite2D
	movement.play("Idle")
	if dir.x == -1:
		movement.flip_h = false
	elif dir.x == 1:
		movement.flip_h = true
	
	
func choose(array):
	array.shuffle()
	return array.front()

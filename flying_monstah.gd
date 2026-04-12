extends CharacterBody2D

class_name Jamur_Terbang

const speed = 40
var dir: Vector2
var is_Jamur_chase: bool
var player_in_range: bool
var player: CharacterBody2D
var projectile_attacking: bool

@onready var projectile = preload("res://proyektil.tscn")

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

func _physics_process(delta: float) -> void:
	var serang = $AnimatedSprite2D
	player = Global.pleyah
	velocity = position.direction_to(player.global_position) * speed
	

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.0, 1.5, 2.0])
	if !is_Jamur_chase:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		print(dir)
	
	if player_in_range:
		var projectiles = projectile.instantiate()
		projectiles.velocity = (player.global_position - global_position).normalized()
		get_parent().add_child(projectiles)
		projectiles.global_position = global_position
		projectile_attacking = true
		
	
func animasi():
	var movement = $AnimatedSprite2D
	if projectile_attacking:
		movement.play("projectile_attack")
		return
	movement.play("Idle")
	if dir.x == -1:
		movement.flip_h = false
	elif dir.x == 1:
		movement.flip_h = true
	
func choose(array):
	array.shuffle()
	return array.front()

func _on_vision_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		print ("body didalam")
	
func _on_vision_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		print ("body diluar")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "projectile_attack":
		projectile_attacking = false

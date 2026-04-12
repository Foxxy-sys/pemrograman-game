extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
var gravity = 9.8 

const WALL_SLIDE_START_SPEED = 50.0
const WALL_SLIDE_MAX_SPEED = 300.0
const WALL_SLIDE_ACCEL = 400.0

const WALL_JUMP_X = 250.0
const WALL_JUMP_Y = -300.0

var wall_slide_speed = 0.0
var is_wall_sliding = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	Global.pleyah = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Wall Sliding
	if is_on_wall() and not is_on_floor():
		var direction = Input.get_axis("jalan_kanan", "jalan_kiri")
		if direction != 0:
			is_wall_sliding = true
			
			wall_slide_speed += WALL_SLIDE_ACCEL * delta
			wall_slide_speed = clamp(wall_slide_speed, WALL_SLIDE_START_SPEED, WALL_SLIDE_MAX_SPEED)
		
		velocity.y = wall_slide_speed
	else:
		wall_slide_speed = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Wall jump
	if Input.is_action_just_pressed("jump") and is_wall_sliding and is_on_wall():
		var wall_normal = get_wall_normal()
	
		velocity.y = WALL_JUMP_Y
		velocity.x = wall_normal.x * WALL_JUMP_X

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# Arah spritenya: -1, 0, 1
	var direction = Input.get_axis("jalan_kanan", "jalan_kiri")
	
	# Memutar spritenya (false -> kiri, true -> kanan)
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true	
	
	# Menajalankan Animasi
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			if Input.is_action_pressed("lari"):
				animated_sprite.play("Lari")
			else:
				animated_sprite.play("Jalan")
	else:
		animated_sprite.play("Loncat")
		if is_on_wall():
			animated_sprite.play("Loncat_Manjat")
		elif velocity.y > 0:
			animated_sprite.play("Jatuh")
	
	#Jalan
	if direction:
		if Input.is_action_pressed("lari"):
			velocity.x = direction * SPEED * 1.5
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	#Core bergerak
	move_and_slide()

	

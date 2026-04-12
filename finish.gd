extends Area2D

var speed_projectile = 300
var velocity: Vector2

func _process(delta):
	var movement = $AnimatedSprite2D
	position += speed_projectile * velocity * delta

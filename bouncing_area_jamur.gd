extends Area2D

const BOUNCE_FORCE = -600.0

func _ready():
	pass

func _on_body_entered(body: Node2D) -> void:
	print ("tes bounce")
	body.velocity.y = BOUNCE_FORCE
	get_parent().play_stun()

extends Area2D
@export var flip_time = 1
var direction = 1
@onready var explosion = preload("res://Scenes/explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = flip_time

func die():
	var new_explosion = explosion.instantiate()
	get_tree().current_scene.add_child(new_explosion)
	new_explosion.global_position = global_position
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2.RIGHT * direction)
	$AnimatedSprite2D.flip_h = direction > 0
	



func _on_timer_timeout():
	direction *= -1 
	

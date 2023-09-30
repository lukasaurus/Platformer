extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RotationPoint.rotation_degrees +=1
	$Flame/Fire.global_position =  $RotationPoint/Marker2D.global_position
	$Flame/Fire2.global_position = $RotationPoint/Marker2D2.global_position
	$Flame/Fire3.global_position = $RotationPoint/Marker2D3.global_position
	$Flame/Fire4.global_position = $RotationPoint/Marker2D4.global_position
	$Flame/Fire5.global_position = $RotationPoint/Marker2D5.global_position
	$Flame/Fire6.global_position = $RotationPoint/Marker2D6.global_position
	$Flame/Fire7.global_position = $RotationPoint/Marker2D7.global_position
	$Flame/Fire8.global_position = $RotationPoint/Marker2D8.global_position

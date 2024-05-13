extends Node

var camera : Camera2D

var screen_width = 320
var screen_heigth = 240

func change_camera_to(target : Camera2D):
	target.enabled = true
	
	if camera != null:
		camera.enabled = false
		
	camera = target

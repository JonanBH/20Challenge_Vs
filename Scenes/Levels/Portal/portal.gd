extends Area2D
class_name Portal

signal entered

@export var connector_room : Room

func _on_body_entered(body):
	connector_room.enable()

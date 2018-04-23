extends KinematicBody2D

export (float) var SPEED = -1

func _physics_process(delta):
    move_and_collide(Vector2(SPEED, 0))
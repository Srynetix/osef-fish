extends Node

#######
# Title

var next_scene = load("res://scenes/screens/Level.tscn")

###################
# Lifecycle methods

func _ready():
    randomize()

func _process(delta):
    var accept = Input.is_action_just_pressed("ui_accept")
    if accept:
        get_tree().change_scene_to(next_scene)

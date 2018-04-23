extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (PackedScene) var NEXT_SCENE

func _process(delta):
    var accept = Input.is_action_just_pressed("ui_accept")
    if accept:
        get_tree().change_scene_to(NEXT_SCENE)
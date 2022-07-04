extends Node

const LevelScene = preload("res://scenes/screens/Level.tscn")

func _ready() -> void:
    randomize()

func _process(_delta: float) -> void:
    var accept = Input.is_action_just_pressed("ui_accept")
    if accept:
        get_tree().change_scene_to(LevelScene)

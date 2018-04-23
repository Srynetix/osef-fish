extends Node

func _on_GameTimer_timeout():
    $Player.player_ready()

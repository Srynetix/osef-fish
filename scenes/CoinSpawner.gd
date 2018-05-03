extends Node2D

export (PackedScene) var COIN
export (float) var SPAWN_TIME = 3.0

func _ready():
    $Timer.connect("timeout", self, "_on_Timer_timeout")
    $Timer.wait_time = SPAWN_TIME
    $Timer.start()

func _on_Timer_timeout():
    var offset = Vector2(0, rand_range(-250, 250))
    spawn_coin($Position.position + offset)

func spawn_coin(pos):
    var instance = COIN.instance()
    instance.position = pos

    var coins = get_tree().get_root().get_node("Top").find_node("Coins")
    coins.add_child(instance)

func stop_spawner():
    # Disable spawner
    $Timer.stop()

    # Handle game exit
    if not get_tree():
        return

    var coins = get_tree().get_root().get_node("Top").find_node("Coins")
    for i in range(coins.get_child_count()):
        var coin = coins.get_child(i)
        coin.stop_moving()
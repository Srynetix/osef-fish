extends Node2D
class_name CoinSpawner

export var coin_scene: PackedScene
export var spawn_time := 3.0
export var container_path: NodePath

onready var _timer: Timer = $Timer
onready var _position: Position2D = $Position
onready var _container_node: Node = get_node(container_path)

func _ready() -> void:
    _timer.connect("timeout", self, "_timeout")
    _timer.wait_time = spawn_time
    _timer.start()

func _timeout() -> void:
    var offset = Vector2(0, rand_range(-250.0, 250.0))
    _spawn_coin(_position.position + offset)

func _spawn_coin(pos: Vector2) -> void:
    var instance = coin_scene.instance()
    instance.position = pos

    _container_node.add_child(instance)

func stop_spawner() -> void:
    # Disable spawner
    _timer.stop()

    # Handle game exit
    if !get_tree():
        return

    for i in range(_container_node.get_child_count()):
        var coin = _container_node.get_child(i)
        coin.stop_moving()

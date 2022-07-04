extends Node2D
class_name TreeSpawner

export var tree_scene: PackedScene
export var spawn_time := 3.0
export var container_path: NodePath

onready var _timer: Timer = $Timer
onready var _ground_pos: Position2D = $GroundPos
onready var _sky_pos: Position2D = $SkyPos
onready var _container_node: Node = get_node(container_path)

func _ready() -> void:
    _timer.connect("timeout", self, "_timeout")
    _timer.wait_time = spawn_time
    _timer.start()

func _spawn_tree(pos: Vector2, rot: float) -> void:
    var instance = tree_scene.instance()
    instance.position = pos
    instance.rotation = rot
    _container_node.add_child(instance)

func stop_spawner() -> void:
    # Disable spawner
    _timer.stop()

    # Handle game exit
    if !get_tree():
        return

    for i in range(_container_node.get_child_count()):
        var tree = _container_node.get_child(i)
        tree.stop_moving()
        
func _timeout() -> void:
    var offset = Vector2(0, rand_range(-100, 100))
    _spawn_tree(_ground_pos.position + offset, deg2rad(0.0))
    _spawn_tree(_sky_pos.position + offset, deg2rad(180.0))

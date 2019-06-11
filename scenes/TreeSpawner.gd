extends Node2D

##############
# Tree Spawner

export (PackedScene) var TREE
export (float) var SPAWN_TIME = 3.0

###################
# Lifecycle methods

func _ready():
    $Timer.wait_time = SPAWN_TIME
    $Timer.start()
    
################
# Public methods

func spawn_tree(pos, rot):
    var instance = TREE.instance()
    instance.position = pos
    instance.rotation = rot

    var trees = get_tree().get_root().get_node("Top").find_node("Trees")
    trees.add_child(instance)

func stop_spawner():
    # Disable spawner
    $Timer.stop()

    # Handle game exit
    if not get_tree():
        return

    var trees = get_tree().get_root().get_node("Top").find_node("Trees")
    for i in range(trees.get_child_count()):
        var tree = trees.get_child(i)
        tree.stop_moving()
        
#################
# Event callbacks

func _on_Timer_timeout():
    var offset = Vector2(0, rand_range(-100, 100))
    spawn_tree($GroundPos.position + offset, deg2rad(0.0))
    spawn_tree($SkyPos.position + offset, deg2rad(180.0))
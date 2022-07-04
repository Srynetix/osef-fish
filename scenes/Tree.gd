extends StaticBody2D
class_name GTree

const SPEED := -150.0

var _moving := false

func _ready() -> void:
    start_moving()

func _physics_process(delta: float) -> void:
    if _moving:
        position.x += SPEED * delta
        
func start_moving():
    _moving = true

func stop_moving():
    _moving = false

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

extends StaticBody2D

export (float) var SPEED = -50

var moving = false

func _ready():
    self.start_moving()

func _physics_process(delta):
    if moving:
        position.x += SPEED * delta

func start_moving():
    moving = true

func stop_moving():
    moving = false

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

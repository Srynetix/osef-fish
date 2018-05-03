extends Area2D

export (float) var BASE_SPEED = 200

var moving = false

func _ready():
    connect("body_entered", self, "on_body_entered")
    $VisibilityNotifier2D.connect("screen_exited", self, "destroy")
    self.start_moving()

func _process(delta):
    if moving:
        position.x -= BASE_SPEED * delta

func start_moving():
    moving = true

func stop_moving():
    moving = false

func on_body_entered(body):
    if body.is_in_group("player"):
        body.emit_signal('score', 1)
        self.destroy()

func destroy():
    queue_free()
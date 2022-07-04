extends Area2D
class_name Coin

export var base_speed := 200.0

onready var _visibility_notifier = $VisibilityNotifier2D

var _moving := false

func _ready() -> void:
    connect("body_entered", self, "_on_body_entered")
    _visibility_notifier.connect("screen_exited", self, "queue_free")
    start_moving()

func _process(delta: float) -> void:
    if _moving:
        position.x -= base_speed * delta
        
func start_moving() -> void:
    _moving = true

func stop_moving() -> void:
    _moving = false
    
func _on_body_entered(body: PhysicsBody2D) -> void:
    if body.is_in_group("player"):
        body.emit_signal('score', 1)
        queue_free()
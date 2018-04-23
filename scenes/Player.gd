extends RigidBody2D

export (int) var GRAVITY_SCALE = 3
export (int) var JUMP_SPEED = -200
export (float) var ANGULAR_SPEED = 0.5

var is_ready = false

func _ready():
    player_reset()

func player_reset():
    gravity_scale = 0
    $Animation.play("idle")
    is_ready = false

func player_ready():
    gravity_scale = GRAVITY_SCALE
    $Animation.play("fly")
    apply_impulse(Vector2(0, 0), Vector2(0, 0))
    is_ready = true

func jump():
    linear_velocity.y = JUMP_SPEED

func _physics_process(delta):
    if is_ready:
        var jump = Input.is_action_just_pressed("ui_accept")
        if jump:
            jump()
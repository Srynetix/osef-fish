extends RigidBody2D
class_name Player

const GRAVITY_SCALE := 3.0
const JUMP_SPEED := -200.0
const ANGULAR_SPEED := 0.5

signal hit()
signal score()

onready var _sprite: Sprite = $Sprite
onready var _animation: AnimationPlayer = $Animation

var _already_hit = false
var _is_ready = false

func _ready() -> void:
    _player_reset()

func _process(_delta: float) -> void:
    var rotation_vel = linear_velocity.y
    _sprite.rotation = deg2rad(rotation_vel * 0.25)

    if _sprite.rotation > deg2rad(90):
        _sprite.rotation = deg2rad(90)
    elif _sprite.rotation < deg2rad(-90):
        _sprite.rotation = deg2rad(-90)

func _physics_process(_delta: float) -> void:
    if _is_ready:
        var jump = Input.is_action_just_pressed("ui_accept")
        if jump:
           _jump()

func player_ready() -> void:
    gravity_scale = GRAVITY_SCALE
    _animation.play("fly")
    _is_ready = true

func out_of_bounds(body):
    if body == self:
        _hit_player(Vector2(0, 2))
 
func _player_reset() -> void:
    gravity_scale = 0
    _animation.play("idle")
    _is_ready = false

func _jump():
    linear_velocity.y = JUMP_SPEED

func _hit_player(direction):
    if !_already_hit:
        _already_hit = true
        _is_ready = false

        apply_impulse(Vector2.ZERO, direction * 5)
        emit_signal("hit")
            
func _on_Player_body_entered(body):
    if body.is_in_group("obstacle"):
        var direction = (body.position - position).normalized() * -1
        _hit_player(direction)
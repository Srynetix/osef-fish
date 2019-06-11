extends RigidBody2D

########
# Player

export (int) var GRAVITY_SCALE = 3
export (int) var JUMP_SPEED = -200
export (float) var ANGULAR_SPEED = 0.5

signal hit
signal score

var already_hit = false
var is_ready = false

###################
# Lifecycle methods

func _ready():
    self.player_reset()

func _process(delta):
    var rotation_vel = linear_velocity.y
    $Sprite.rotation = deg2rad(rotation_vel * 0.25)

    if $Sprite.rotation > deg2rad(90):
        $Sprite.rotation = deg2rad(90)
    elif $Sprite.rotation < deg2rad(-90):
        $Sprite.rotation = deg2rad(-90)

func _physics_process(delta):
    if is_ready:
        var jump = Input.is_action_just_pressed("ui_accept")
        if jump:
            jump()
        
################
# Public methods

func player_reset():
    gravity_scale = 0
    $Animation.play("idle")
    is_ready = false

func player_ready():
    gravity_scale = GRAVITY_SCALE
    $Animation.play("fly")
    is_ready = true

func jump():
    linear_velocity.y = JUMP_SPEED

func hit_player(direction):
    if not already_hit:
        already_hit = true
        is_ready = false

        apply_impulse(Vector2(0, 0), direction * 5)
        emit_signal("hit")

func out_of_bounds(body):
    if body == self:
        self.hit_player(Vector2(0, 2))
            
#################
# Event callbacks

func _on_Player_body_entered(body):
    if body.is_in_group("obstacle"):
        var direction = (body.position - position).normalized() * -1
        self.hit_player(direction)
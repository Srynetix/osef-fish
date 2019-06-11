extends StaticBody2D

######
# Tree

const SPEED = -150

var moving = false

###################
# Lifecycle methods

func _ready():
    self.start_moving()

func _physics_process(delta):
    if moving:
        position.x += SPEED * delta
        
################
# Public methods

func start_moving():
    moving = true

func stop_moving():
    moving = false

#################
# Event callbacks

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()

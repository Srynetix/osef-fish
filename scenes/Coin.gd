extends Area2D

######
# Coin

export (float) var BASE_SPEED = 200

var moving = false

###################
# Lifecycle methods

func _ready():
    connect("body_entered", self, "on_body_entered")
    $VisibilityNotifier2D.connect("screen_exited", self, "destroy")
    self.start_moving()

func _process(delta):
    if moving:
        position.x -= BASE_SPEED * delta
        
################
# Public methods

func start_moving():
    moving = true

func stop_moving():
    moving = false
    
func destroy():
    queue_free()
    
#################
# Event callbacks

func on_body_entered(body):
    if body.is_in_group("player"):
        body.emit_signal('score', 1)
        self.destroy()
extends Sprite

#####
# Sky

###################
# Lifecycle methods

func _ready():
    self.start_anim()
    
################
# Public methods

func start_anim():
    $AnimationPlayer.play('Moving')

func stop_anim():
    $AnimationPlayer.stop()
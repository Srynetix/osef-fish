extends StaticBody2D

########
# Ground

###################
# Lifecycle methods

func _ready():
    self.start_anim()
    
################
# Public methods

func start_anim():
    $AnimationPlayer.play('moving')

func stop_anim():
    $AnimationPlayer.stop()
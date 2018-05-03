extends StaticBody2D

func _ready():
    self.start_anim()

func start_anim():
    $AnimationPlayer.play('moving')

func stop_anim():
    $AnimationPlayer.stop()
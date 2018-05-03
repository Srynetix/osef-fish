extends Sprite

func _ready():
    self.start_anim()

func start_anim():
    $AnimationPlayer.play('Moving')

func stop_anim():
    $AnimationPlayer.stop()
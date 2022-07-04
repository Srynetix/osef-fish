extends Sprite
class_name GSky

onready var _animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    _animation_player.play('moving')
    
func stop_anim() -> void:
    _animation_player.stop()
extends Node

onready var _player: Player = $Player
onready var _game_zone: Area2D = $GameZone
onready var _score_label: Label = $UI/Score
onready var _game_over_label: Label = $UI/GameOverLabel
onready var _game_over_timer: Timer = $GameOverTimer
onready var _game_over_animation_player: AnimationPlayer = $UI/GameOverLabel/AnimationPlayer
onready var _game_over_instructions_label: Label = $UI/GameOverInstructions
onready var _game_over_instructions_animation_player: AnimationPlayer = $UI/GameOverInstructions/AnimationPlayer
onready var _ground: Ground = $Ground
onready var _tree_spawner: TreeSpawner = $TreeSpawner
onready var _coin_spawner: CoinSpawner = $CoinSpawner

var _is_game_over = false
var _score = 0

func _ready() -> void:
    _player.connect('hit', self, '_game_over')
    _player.connect('score', self, '_update_score')
    _game_zone.connect('body_exited', _player, 'out_of_bounds')
    
func _process(_delta: float) -> void:
    if _is_game_over:
        var accept = Input.is_action_just_pressed("ui_accept")
        if accept:
            get_tree().change_scene("res://scenes/screens/Title.tscn")
    
func _update_score(amount: float) -> void:
    _score += amount
    _score_label.set_text("%d" % _score)

func _game_over() -> void:
    _game_over_animation_player.play('show')
    _game_over_label.show()
    _game_over_instructions_animation_player.play('blink')
    _game_over_instructions_label.show()

    # Stop scrolling
    _ground.stop_anim()
    _tree_spawner.stop_spawner()
    _coin_spawner.stop_spawner()

    _game_over_timer.start()
            
#################
# Event callbacks

func _on_GameStartTimer_timeout():
    _player.player_ready()

func _on_GameOverTimer_timeout():
    _is_game_over = true

extends Node

var is_game_over = false

var score = 0
var title_scene = load("res://scenes/screens/Title.tscn")

func _ready():
    $Player.connect('hit', self, 'game_over')
    $Player.connect('score', self, 'update_score')
    $GameZone.connect('body_exited', $Player, 'out_of_bounds')

func _on_GameStartTimer_timeout():
    $Player.player_ready()

func _on_GameOverTimer_timeout():
    is_game_over = true

func update_score(amount):
    score += amount
    $UI/Score.set_text("%d" % score)

func game_over():
    # Game over !
    $UI/GameOverLabel/AnimationPlayer.play('Show')
    $UI/GameOverLabel.show()
    $UI/GameOverInstructions/AnimationPlayer.play('blink')
    $UI/GameOverInstructions.show()

    # Stop scrolling
    $Ground.stop_anim()
    $TreeSpawner.stop_spawner()
    $CoinSpawner.stop_spawner()

    $GameOverTimer.start()

func _process(delta):
    if is_game_over:
        var accept = Input.is_action_just_pressed("ui_accept")
        if accept:
            get_tree().change_scene_to(title_scene)
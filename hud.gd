extends CanvasLayer

signal game_started

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_highscore(score):
	$HighscoreLabel.text = str(score)
	
func message_visibility(visibility_value):
	$Message.visible = visibility_value
	$HighscoreLabel.visible = visibility_value
	
func set_message(msg):
	$Message.text = msg
	
func button_visibility(visibility_value):
	$GameStartButton.visible = visibility_value

func _on_game_start_button_start_game_pressed():
	game_started.emit()

extends Node

@export var pipes_scene : PackedScene
var score = 0
var defaultBirdPosition = Vector2(100, 100)
var pipes_speed = 200
var highscore = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$bird.gravity = 0
	#get_tree().debug_collisions_hint = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_start():
	$bird.position = defaultBirdPosition
	score = 0
	$bird.visible = true
	$PipesGeneratorTimer.start()
	$HUD.message_visibility(false)
	$HUD.button_visibility(false)
	$bird.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	$HUD.update_score(score)
	$PipesGeneratorTimer.start(0)
	$HUD.message_visibility(false);
	$HUD.button_visibility(false)
	
	#await get_tree().create_timer(1).timeout
	
func game_over():
	pipes_speed =200
	if(score > highscore):
		highscore = score
		$HUD.update_highscore(highscore)
	score =0;
	#$bird.gravity = 0
	$bird.visible = false
	$HUD.set_message('\nPlay again?')
	$HUD.message_visibility(true)
	$HUD.button_visibility(true)
	get_tree().call_group("pipes", "queue_free")
	$PipesGeneratorTimer.stop()

func _on_pipes_generator_timer_timeout():
	var pipe = pipes_scene.instantiate()
	#Prelucrare pipe...
	#pipe.get_child(0).connect("asdrea_entered", when_the_bird_scores)
	pipe.get_child(0).monitoring = true
	pipe.speed = pipes_speed
	update_pipes_speed(pipes_speed)
	$background.add_child(pipe)

func update_pipes_speed(speed):
	var all_pipes = get_tree().get_nodes_in_group("pipes")
	for pipeset in all_pipes:
		print(pipeset.speed)
		pipeset.speed = speed
	print("RANDNOU")

func _on_bird_something_hit():
	game_over()


func _on_hud_game_started():
	print('apasat')
	game_start()


func _on_score_timer_timeout():
	score +=1
	$HUD.update_score(score)
	if(score % 2 == 0):
		pipes_speed += 25


func _on_bird_score_triggered_by_bird(obj_lovit):
	$ScoreTimer.start(0.01)
	#print(obj.get_name())
	obj_lovit.get_child(0).disabled = true

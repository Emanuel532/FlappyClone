extends Node

var speed = 200
signal score_triggered
# Called when the node enters the scene tree for the first time.
func _ready():
	#Generate a random pipe 
	generate_and_set_random_position_pipe()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move the pipes
	$Pipe.position.x -= speed*delta
	$ScorePipe.position.x -= speed*delta
	$Pipe2.position.x -= speed*delta


func generate_and_set_random_position_pipe():
	var rand_num = randi() % 3;
	
	match(rand_num):
		0:
			$Pipe.position.y += 250
			$Pipe2.position.y -= 150
		1:
			$Pipe.position.y += 0
			$Pipe2.position.y -= 450
		2:
			$Pipe.position.y += 425
			$Pipe2.position.y += 0


func _on_pipe_exit_screen():
	queue_free()




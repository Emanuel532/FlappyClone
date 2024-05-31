extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var screen_size;


signal something_hit()

signal score_triggered_by_bird(collider_object)


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false

func _ready():
	$AnimatedSprite2D.play("fly")
	screen_size = get_viewport_rect().size;

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if(velocity.y != 0): #handle bird rotation
		$AnimatedSprite2D.rotation = velocity_y_to_rotation_degree(velocity.y)
		#print(velocity_y_to_rotation_degree(velocity.y))
	# Handle jump.
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_jump")) and !is_jumping:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		$JumpingCooldown.start(0.1);

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#print(velocity)
	
	#Clamp the bird position onto the screen
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()


	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		#print("Collided with: ", collision.get_collider())
		if collision.get_collider().name == "Ground" or collision.get_collider().name == "Pipe" or collision.get_collider().name == "Pipe2":
			something_hit.emit()
		if collision.get_collider().name == "ScorePipe":
			score_triggered_by_bird.emit(collision.get_collider())



func _on_jumping_cooldown_timeout():
	is_jumping=false

func velocity_y_to_rotation_degree(velocity_y: float) -> float:
	var degree =0
	if velocity_y >= -390.0 and velocity_y < 0.0:
		degree = lerp(0.0, -45.0, velocity_y / -390.0)
	elif velocity_y > 0.0 and velocity_y <= 1500.0:
		degree = lerp(0.0, 45.0, velocity_y / 1500.0)
	else:
		degree = 0.0
	
	var radians = deg_to_rad(degree)
	return radians

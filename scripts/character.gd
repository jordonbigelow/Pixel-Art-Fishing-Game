extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@export var speed = 400

func _physics_process(delta: float) -> void:
	var input_direction = Vector2.ZERO

	# Capture input for movement
	input_direction.x += Input.get_action_strength("move_right")
	input_direction.x -= Input.get_action_strength("move_left")
	input_direction.y += Input.get_action_strength("move_down")
	input_direction.y -= Input.get_action_strength("move_up")

	# Handle animations
	if input_direction != Vector2.ZERO:
		if input_direction.x != 0 and input_direction.y == 0:
			# Pure horizontal movement
			_animated_sprite.flip_h = input_direction.x < 0
			_animated_sprite.play("walking")
		elif input_direction.y != 0 and input_direction.x == 0:
			# Pure vertical movement
			if input_direction.y > 0:
				_animated_sprite.play("walking_down")
			else:
				_animated_sprite.play("walking_up")
		else:
			# Diagonal or combined movement
			_animated_sprite.flip_h = input_direction.x < 0
			_animated_sprite.play("walking")
	else:
		# Stop animation if no input
		_animated_sprite.stop()

	# Move the character
	velocity = input_direction.normalized() * speed
	move_and_slide()

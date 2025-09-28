extends CharacterBody2D

const PUSH_FORCE = 100
const MAX_VELOCITY = 150
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@onready var animation = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta
	animation.flip_v = false
	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("ui_down"):
		animation.flip_v = true
	
	if is_on_floor():
		animation.rotation_degrees = 0	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction / abs(direction) == 1:
			animation.flip_h = false
			if !is_on_floor():
				animation.rotation_degrees = 270
		if direction / abs(direction) == -1:
			animation.flip_h = true
			if !is_on_floor():
				animation.rotation_degrees = 90
		
		velocity.x = direction * SPEED
		animation.play("wave")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		animation.stop()
		
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_crate = collision.get_collider()
		if collision_crate.is_in_group("crates") and abs(collision_crate.get_linear_velocity().x) < MAX_VELOCITY:
			collision_crate.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
			
		

	move_and_slide()

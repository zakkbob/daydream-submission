extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 100
const MAX_VELOCITY = 150

func _physics_process(delta: float) -> void:
    # Add the gravity.
    velocity += get_gravity() * delta

    # Handle jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction := Input.get_axis("ui_left", "ui_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        
    for i in get_slide_collision_count():
        var collision = get_slide_collision(i)
        var collision_crate = collision.get_collider()
        if collision_crate.is_in_group("crates") and abs(collision_crate.get_linear_velocity().x) < MAX_VELOCITY:
            collision_crate.apply_central_impulse(collision.get_normal() * -PUSH_FORCE)
            
        

    move_and_slide()

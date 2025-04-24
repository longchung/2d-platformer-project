extends CharacterBody2D
var speed = 700.0
var jump_power = -800.0
var grav = 1700
var jump_time = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += grav * delta
		
	if Input.is_action_just_pressed("jump") and  jump_time<2:
		velocity.y = jump_power
		jump_time+=1
	if jump_time ==2 and is_on_floor():
		jump_time=0 
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x =  move_toward(velocity.x,0,speed)
		
	move_and_slide()

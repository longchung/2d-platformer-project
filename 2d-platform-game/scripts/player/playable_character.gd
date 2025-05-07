extends CharacterBody2D

class_name MyPlayer
@export var spliperry= 0.01
@export var speed = 300.0
@export var jump_power = -400.0
@export var ice_speed = 200.0
@export var ice_jump_power = -250.0
@export var grav = 1000.0
var jump_time = 0
@export var double_jump=false
var current_speed= speed
var current_jump= jump_power
@onready var check_ice_mid: RayCast2D = $checkice
@onready var check_ice_right: RayCast2D = $checkice2
@onready var check_ice_left: RayCast2D = $checkice3

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += grav * delta 
	
	if double_jump ==true:
		if Input.is_action_just_pressed("jump") and  jump_time<2:
			velocity.y = current_jump
			jump_time+=1
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = current_jump
		
	if jump_time ==2 and is_on_floor():
		jump_time=0 
		
	var direction = Input.get_axis("move_left","move_right")
	var collider1 = check_ice_mid.get_collider()
	var collider2 = check_ice_right.get_collider()
	var collider3 = check_ice_left.get_collider()
	if (not collider1 and not collider2) or (not collider2 and not collider3) or (not collider1 and not collider3):
		current_speed= speed
		current_jump= jump_power
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x =  move_toward(velocity.x,0.0,speed)
	
	else:
		current_speed= ice_speed
		current_jump= ice_jump_power
		if direction:
			velocity.x = lerp(velocity.x,direction * speed,0.01)
		else:
			velocity.x =  lerp(velocity.x,0.0,0.005)
			if velocity.x < 150 or velocity.x > -150:
				velocity.x = 0.0

	move_and_slide()

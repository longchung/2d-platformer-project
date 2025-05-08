extends CharacterBody2D
#This cript act as the base for all playble character
#to be created from in this case both Mario and luigi is extended form this 
#class by adjusting the exported value to suit that character
#Mario has greater jump height and speed than Luigi, but Luigi can double jump
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
#each raycast check if tile standing on is ice.
@onready var check_ice_mid: RayCast2D = $checkice
@onready var check_ice_right: RayCast2D = $checkice2
@onready var check_ice_left: RayCast2D = $checkice3

func _physics_process(delta):
	#check if player is in the air then begin to fall
	if not is_on_floor():
		velocity.y += grav * delta 
	
	#check if this character has the ability to double jump
	#if yes then use jump_time to double jump
	if double_jump ==true: 
		if Input.is_action_just_pressed("jump") and  jump_time<2:
			velocity.y = current_jump
			jump_time+=1
	#if no then just single jump
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = current_jump
	
	#if double jumped and now is on the ground reset jump_time to allow
	#double jump again 	
	if jump_time ==2 and is_on_floor():
		jump_time=0 
		
	var direction = Input.get_axis("move_left","move_right")
	var collider1 = check_ice_mid.get_collider()
	var collider2 = check_ice_right.get_collider()
	var collider3 = check_ice_left.get_collider()
	
	#this is for movement
	#check if any of at least 2 raycast saw a collision Mask 2 which is ice
	#if no then normal movement and speed
	if (not collider1 and not collider2) or (not collider2 and not collider3) or (not collider1 and not collider3):
		current_speed= speed
		current_jump= jump_power
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x =  move_toward(velocity.x,0.0,speed)
	#if yes then set current speed and jump power to the slower one
	#then cause the player movement to be slippery
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

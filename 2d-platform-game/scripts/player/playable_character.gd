extends CharacterBody2D
#This cript act as the base for all playble character
#to be created from in this case both Mario and luigi is extended form this 
#class by adjusting the exported value to suit that character
#Mario has greater jump height and speed than Luigi, but Luigi can double jump
class_name MyPlayer
@onready var jump_sound: AudioStreamPlayer = $jump_sound
@onready var walk_sound: AudioStreamPlayer = $walk_sound
@onready var playersprite: AnimatedSprite2D = $playersprite


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
@onready var check_ice_mid = $checkice
@onready var check_ice_right = $checkice2
@onready var check_ice_left = $checkice3
@onready var hurt = $playersprite/AnimationPlayer
func _physics_process(delta):
	#check if player is in the air then begin to fall
	if not is_on_floor():
		velocity.y += grav * delta
	var direction = Input.get_axis("move_left","move_right")
	var collider1 = check_ice_mid.get_collider()
	var collider2 = check_ice_right.get_collider()
	var collider3 = check_ice_left.get_collider()
	#check if this character has the ability to double jump
	#if yes then use jump_time to double jump
	if double_jump ==true: 
		if Input.is_action_just_pressed("jump") and  jump_time<2:
			velocity.y = current_jump
			playersprite.play("jumping")
			playersprite.flip_h = direction <0
			jump_sound.play()
			jump_time+=1
	#if no then just single jump
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = current_jump
			playersprite.play("jumping")
			playersprite.flip_h = direction <0
			jump_sound.play()
	
	#if double jumped and now is on the ground reset jump_time to allow
	#double jump again 	
	if jump_time ==2 and is_on_floor():
		playersprite.play("idle")
		jump_time=0 
	
	#this is for movement
	#check if any of at least 2 raycast saw a collision Mask 2 which is ice
	#if no then normal movement and speed
	if (not collider1 and not collider2) or (not collider2 and not collider3) or (not collider1 and not collider3):
		$Camera2D/ColorRect2.material.set_shader_parameter("snowon",1.0)
		current_speed= speed
		current_jump= jump_power
		if direction:
			if !walk_sound.playing and is_on_floor() :
				walk_sound.play()
			velocity.x = direction * speed
			if is_on_floor() :
				playersprite.play("walk")
				playersprite.flip_h = direction<0
			else:
				playersprite.play("jumping")
				playersprite.flip_h = direction <0
		else:
			velocity.x =  move_toward(velocity.x,0.0,speed)
			playersprite.play("idle")
			walk_sound.stop()
	#if yes then set current speed and jump power to the slower one
	#then cause the player movement to be slippery
	else:
		$Camera2D/ColorRect2.material.set_shader_parameter("snowon",0.5)
		current_speed= ice_speed
		current_jump= ice_jump_power
		if direction:
			if !walk_sound.playing and is_on_floor() :
				walk_sound.play()
			velocity.x = lerp(velocity.x,direction * speed,0.01)
			if is_on_floor() :
				playersprite.play("walk")
				playersprite.flip_h = direction <0
			else:
				playersprite.play("jumping")
				playersprite.flip_h = direction <0
		else:
			velocity.x =  lerp(velocity.x,0.0,0.005)
			if velocity.x < 150 or velocity.x > -150:
				velocity.x = 0.0
				walk_sound.stop()
				playersprite.play("idle")
	move_and_slide()
	
	
#this is for when the player thit an obstacle
#which is mask 3. They will reduce their score
#by 10 and play the player flash a color 
#animaion using the hurt shader
func _on_area_2d_area_entered(area: Area2D) -> void:
	if AllWorld.total_score > 0:
		AllWorld.total_score -= 10
	else:
		AllWorld.total_score = 0
	AllWorld.play_sound2=2
	hurt.play("flash_hurt")
	$Timer.start()

# wait 2s to play the sader then stop it	
func _on_timer_timeout() -> void:
	hurt.stop()


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if AllWorld.total_score > 0:
		AllWorld.total_score -= 10
	else:
		AllWorld.total_score = 0
	AllWorld.play_sound2=3
	hurt.play("flash_hurt")
	$Timer2.start()


func _on_timer_2_timeout() -> void:
	hurt.stop()
func _process(delta: float) -> void:
	if AllWorld.level==2:
		$Camera2D/ColorRect.material.set_shader_parameter('bright',1.0)
		$Camera2D/ColorRect.material.set_shader_parameter('bright2',1.0)
	else:
		$Camera2D/ColorRect.material.set_shader_parameter('bright',0.0)
		$Camera2D/ColorRect.material.set_shader_parameter('bright2',0.0)
		
		

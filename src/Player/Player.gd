extends KinematicBody2D
class_name Player

const UP = Vector2(0,-1)
const GRAVITY = 10
const MAXFALLSPEED = 200
const MAXSPEED = 30
const JUMPFORCE = 150
const ACCEL= 2

var motion = Vector2()
var facing_right= true

func _ready():
	pass

func _physics_process(delta):

	motion.y += GRAVITY
	if motion.y> MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	if facing_right== true:
		$Sprite.scale.x= 1
	else:
		$Sprite.scale.x= -1

	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right= true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right= false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x,0,0.15)
		$AnimationPlayer.play("Idle")
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
		
		
	motion.y = move_and_slide(motion,UP, true).y
	

func _on_Sign_area_entered(area):
	pass # Replace with function body.

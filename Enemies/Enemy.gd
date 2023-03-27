class_name EnemyUnit
extends CharacterBody2D

const SPEED = 300.0

func _init():
	pass 
	#add_to_group("")
	
func _physics_process(delta):
	move_and_slide()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func search_route(): 
	pass
	
func update_animation():
	pass
	
func _ready():
	pass
	
func scream_from_damage():
	pass
	

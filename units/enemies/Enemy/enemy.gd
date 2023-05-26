class_name Enemy extends BaseUnit

## Золото за убийство
@export var gold_reward: int = 10

var path_follower: EnemyPathFollower


func _init():
	add_to_group("enemies")


## Установить новый EnemyPathFollower
func set_path_follower(follower: EnemyPathFollower):
	path_follower = follower
	position = path_follower.get_position()


## Смерть юнита
func die():
	Game.gold += gold_reward
	super.die()


func _physics_process(delta: float):
	if not is_dead():
		if state == UnitState.IDLE:
			state = UnitState.WALKING	
		if path_follower and state == UnitState.WALKING:
			if path_follower.is_end_reached():
				path_follower = null
				queue_free()
			else:
				velocity = path_follower.follow_path(position, move_speed)
	super._physics_process(delta)

extends Enemy

func _ready():
	$AnimationPlayer.play("walk")
	health=health*2
	super._ready()

class_name Mutant extends Enemy

func _ready():
	$AnimationPlayer.play("walk")
	super._ready()

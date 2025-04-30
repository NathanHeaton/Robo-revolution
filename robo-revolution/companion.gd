extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
	UpgradeManager.connect("upgrade", Callable(self, "_upgrade"))
	$animations.play("idle_companion")


func _physics_process(delta: float) -> void:
	# Add the gravity.

	move_and_slide()

extends AnimatedSprite

var zeroToMax = false
onready var zero_to_max_timer = $ZeroToMaxTimer

func zero_to_max() -> void:
	zeroToMax = true
	zero_to_max_timer.start(0.2)

func _on_ZeroToMaxTimer_timeout() -> void:
	if self.frame != 8:
		self.frame = self.frame + 1
	else:
		zeroToMax = false
		zero_to_max_timer.stop()

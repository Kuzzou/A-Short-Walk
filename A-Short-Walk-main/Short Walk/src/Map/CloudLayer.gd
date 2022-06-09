extends ParallaxLayer

export(float) var CLOUDSPEED = -15

func _process(delta) -> void:
	self.motion_offset.x += CLOUDSPEED *delta
	

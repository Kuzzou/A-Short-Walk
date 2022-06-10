extends Area2D
class_name Sign

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

#Not implemented - we'll use the default texture instead
#func interaction_get_texture() -> Texture:
#	pass

func interaction_get_text() -> String:
	return "Open"


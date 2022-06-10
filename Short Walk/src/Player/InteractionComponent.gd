extends Area2D

export var interaction_parent: NodePath
export var ui_scene: PackedScene

signal on_interactable_changed(newInteractable)

var interaction_target: Node 


func _process(delta):
	#Check whethever the player is trying to interact
	if (interaction_target != null and Input.is_action_just_pressed("interact")):
		#If so, we'll call interaction_interact() if our target supports it
		if (interaction_target.has_method("interaction_interact")):
			interaction_target.interaction_interact(self)


#Signal triggered when our collider collides with something on the interaction layer
func _on_InteractionComponent_body_entered(body):
	
	var canInteract := false
	
	#GDScript lack the concept of interfaces. so we can't check whether the body implements an interface
	#Instead, we'll see if it has the methods we need
	if (body.has_method("interaction_can_interact")):
		#Interactables tell us wether we're allowed to interact with them.
		canInteract= body.interaction_can_interact(get_node(interaction_parent))
	
	if not canInteract:
		return
	
	#Store the thing we'll be interacting with, so we can trigger it from _process
	interaction_target= body
	emit_signal("on_interactable_changed", interaction_target)


func _on_InteractionComponent_body_exited(body):
	if (body == interaction_target):
		interaction_target= null
		emit_signal("on_interactable_changed", null)


func _on_InteractionComponent_area_entered(area):
	var canInteract:= false
	var scene= load("res://src/PLayer/InteractionComponentUI.tscn")
	var instance = scene.instance()
	area.add_child(instance)
	
	if (area.has_method("interaction_can_interact")):
		canInteract=area.interaction_can_interact(get_node(interaction_parent))
	
	
	if not canInteract:
		return
	
	interaction_target= area
	emit_signal("on_interactable_changed", interaction_target)

func _on_InteractionComponent_area_exited(area):
	if (area== interaction_target):
		interaction_target=null
		emit_signal("on_interactable_changed", null)
	var instance= queue_free()

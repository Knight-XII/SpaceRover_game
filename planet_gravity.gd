extends Node2D

@export var gravity_strength: float = 30.0

func _physics_process(delta):
	# Get all bodies in the scene that should be affected by gravity
	for body in get_tree().get_nodes_in_group("gravity_objects"):
		if body is RigidBody2D:
			var direction = global_position.direction_to(body.global_position)
			var distance = global_position.distance_to(body.global_position)

			# Weakens with distance (optional but realistic)
			var force = direction * gravity_strength / max(distance, 50)

			body.apply_force(Vector2.ZERO, force)

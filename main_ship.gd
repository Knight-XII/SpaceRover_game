extends RigidBody2D

@export var thrust_strength: float = 400.0

@export var engine_back: NodePath
@export var engine_top: NodePath
@export var engine_bottom: NodePath
@export var engine_support: NodePath

var e_back
var e_top
var e_bottom
var e_support

func _ready():
	e_back = get_node(engine_back)
	e_top = get_node(engine_top)
	e_bottom = get_node(engine_bottom)
	e_support = get_node(engine_support)

func _physics_process(delta):
	var right = global_transform.x.normalized()
	var down  = global_transform.y.normalized()
	var up    = -down
	var left  = -right

	# TOP ENGINE (T) -> pushes ship downward
	if Input.is_action_pressed("thrust_top"):
		_fire(e_top, down * thrust_strength)

	# BOTTOM ENGINE (B) -> pushes ship upward
	if Input.is_action_pressed("thrust_bottom"):
		_fire(e_bottom, up * thrust_strength)

	# BACK ENGINE (X) -> pushes ship forward
	if Input.is_action_pressed("thrust_back"):
		_fire(e_back, up * thrust_strength)

	# SUPPORT ENGINE (F) -> side thrust
	if Input.is_action_pressed("thrust_support"):
		_fire(e_support, right * thrust_strength)

func _fire(engine, force):
	var offset = engine.global_position - global_position
	apply_force(offset, force)

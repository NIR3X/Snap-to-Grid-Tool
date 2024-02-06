tool
extends Spatial

export var x_axis : bool = true
export var y_axis : bool = true
export var z_axis : bool = true

export var positioning_step : Vector3 = Vector3(1, 1, 1)
export var positioning_offset : Vector3 = Vector3(0.5, 0.5, 0.5)
export var position_offset : Vector3 = Vector3(0, 0, 0)
export var scaling_step : Vector3 = Vector3(1, 1, 1)

var is_positioned : bool = false

# Snaps the object's position and scale to a grid based on the specified parameters.
func snap_to_grid():
	var pos: Vector3
	if not is_positioned:
		is_positioned = true
		pos = transform.origin
		transform.origin = Vector3(
			pos.x + position_offset.x,
			pos.y + position_offset.y,
			pos.z + position_offset.z
		)

	pos = transform.origin

	if x_axis:
		transform.origin.x = round(
			(pos.x - positioning_offset.x) / positioning_step.x
		) * positioning_step.x + positioning_offset.x

	if y_axis:
		transform.origin.y = round(
			(pos.y - positioning_offset.y) / positioning_step.y
		) * positioning_step.y + positioning_offset.y

	if z_axis:
		transform.origin.z = round(
			(pos.z - positioning_offset.z) / positioning_step.z
		) * positioning_step.z + positioning_offset.z

	scaling_step.x = min(1, scaling_step.x)
	scaling_step.y = min(1, scaling_step.y)
	scaling_step.z = min(1, scaling_step.z)

	var local_scale: Vector3 = scale
	scale = Vector3(
		round(local_scale.x / scaling_step.x) * scaling_step.x,
		round(local_scale.y / scaling_step.y) * scaling_step.y,
		round(local_scale.z / scaling_step.z) * scaling_step.z
	)

# This function is called every frame during the game's execution.
# If the game is running in the editor, it calls the `snap_to_grid()` function.
func _process(_delta: float):
	if Engine.is_editor_hint():
		snap_to_grid()

class_name MathHelper

const DEFAULT_DECIMAL_PLACES = 3

static func frame_independent_lerp(start, finish, rate_of_change: float, delta: float):
	var weight := 1 - exp(-rate_of_change * delta)
	return start.lerp(finish, weight)

static func aabb_3d_to_2d(aabb: AABB, camera: Camera3D, limit: Rect2 = Rect2(0.0, 0.0, 0.0, 0.0)) -> Rect2:
	var limits := camera.get_viewport().get_visible_rect()
	limits.position += limit.position
	limits.size -= limit.size

	var start := +Vector2.INF
	var end := -Vector2.INF

	for index in range(8):
		var point := limit_vector2_by_rect2(camera.unproject_position(aabb.get_endpoint(index)), limits)
		start = start.min(point)
		end = end.max(point)
	
	return Rect2(start, end)

static func limit_vector2_by_rect2(vector: Vector2, rect: Rect2) -> Vector2:
	return vector.min(rect.size).max(rect.position)

static func random_vector3_range(min_vector: Vector3, max_vector: Vector3) -> Vector3:
	return Vector3(randf_range(min_vector.x, max_vector.x), randf_range(min_vector.y, max_vector.y), randf_range(min_vector.z, max_vector.z))

static func coalesce(a, b):
	return a if a else b

static func swap_vector2i(vector: Vector2i) -> Vector2i:
	return Vector2i(vector.y, vector.x)

static func swap_vector2(vector: Vector2) -> Vector2:
	return Vector2(vector.y, vector.x)

static func transform_without_position(transform: Transform3D) -> Transform3D:
	transform.origin = Vector3.ZERO
	return transform

static func scale_packed_vector2_array(array: PackedVector2Array, scalar: float) -> PackedVector2Array:
	if (scalar == 1.0):
		return array
	var duplicate = array.duplicate()
	for index in duplicate.size():
		duplicate[index] = duplicate[index] * scalar
	return duplicate

static func deg_to_rad_vector3(vector: Vector3) -> Vector3:
	return Vector3(deg_to_rad(vector.x), deg_to_rad(vector.y), deg_to_rad(vector.z))

static func angle_towards(position0: Vector3, position1: Vector3) -> float:
	var difference: Vector3 = (position0 - position1).normalized()
	return atan2(difference.y, difference.x) + PI

## [codeblock]
## get_text_for_bool(true) # "enabled"
## get_text_for_bool(false) # "disabled"
## [/codeblock]
static func get_text_for_bool(value: bool) -> String:
	return "enabled" if value else "disabled"

## [codeblock]
## uid_to_filename("uid://mq04lc8tubb6") # "res://icon.svg"
## uid_to_filename("res://icon.svg") # "res://icon.svg"
## [/codeblock]
static func uid_to_normal_path(path: String) -> String:
	if path.begins_with("uid://"):
		return ResourceUID.get_id_path(ResourceUID.text_to_id(path))
	else:
		return path

## [codeblock]
## uid_to_filename("uid://mq04lc8tubb6") # "icon"
## uid_to_filename("res://icon.svg") # "icon"
## [/codeblock]
static func uid_to_filename(path: String) -> String:
	return uid_to_normal_path(path).get_file().get_basename()

## This assumes number of physics frames per second doesn't change at runtime
## [codeblock]
## convert_physics_frames_to_seconds(1) # 0.01666666
## [/codeblock]
static func convert_physics_frames_to_seconds(ticks: int) -> float:
	return round_to_dec(float(ticks) / Engine.physics_ticks_per_second)

## [codeblock]
## format_speed_timer(128.516123) # "02:08.516"
## [/codeblock]
static func format_speed_timer(time: float) -> String:
	var milliseconds := fmod(time, 1.0) * 1000
	time = floor(time)
	var seconds := fmod(time, 60.0)
	time /= 60.0
	var minutes: int = floor(time)

	if (minutes > 99):
		minutes = 99
		seconds = 59
		milliseconds = 999

	var text := ("%02d.%03d" % [seconds, milliseconds])
	if (minutes > 0):
		text = ("%02d:" % [minutes]) + text

	return text

static func within_range(value, within_range_of, threshold):
	return value >= within_range_of - threshold and value <= within_range_of + threshold

## [codeblock]
## format_percentage(0.25) # "25%"
## [/codeblock]
static func format_percentage(value: float) -> String:
	return "%.0f%%" % round(value * 100.0)

static func round_to_dec(num: float, digit: float = DEFAULT_DECIMAL_PLACES) -> float:
	return floor(num * pow(10.0, digit)) / pow(10.0, digit)

static func seconds_to_milliseconds(time: float) -> int:
	return floor(round_to_dec(time) * 1000.0)

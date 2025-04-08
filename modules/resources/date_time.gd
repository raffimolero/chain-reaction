extends Resource
class_name DateTime

# Exported properties for editor visibility
@export var year: int = 1970:
	set(value):
		year = value
		_update_internal()

@export var month: int = 1:
	set(value):
		month = clamp(value, 1, 12)
		_update_internal()

@export var day: int = 1:
	set(value):
		day = clamp(value, 1, _days_in_month(year, month))
		_update_internal()

@export var hour: int = 0:
	set(value):
		hour = clamp(value, 0, 23)
		_update_internal()

@export var minute: int = 0:
	set(value):
		minute = clamp(value, 0, 59)
		_update_internal()

@export var second: int = 0:
	set(value):
		second = clamp(value, 0, 59)
		_update_internal()

@export var millisecond: int = 0:
	set(value):
		millisecond = clamp(value, 0, 999)
		_update_internal()

@export var microsecond: int = 0:
	set(value):
		microsecond = clamp(value, 0, 999)
		_update_internal()

@export var is_utc: bool = false

# Internal variables
var _year: int
var _month: int
var _day: int
var _hour: int
var _minute: int
var _second: int
var _millisecond: int
var _microsecond: int
var _is_utc: bool

# Constructor with prefixed parameters
func _init(p_year: int = 1970, p_month: int = 1, p_day: int = 1, p_hour: int = 0, 
		  p_minute: int = 0, p_second: int = 0, p_millisecond: int = 0, 
		  p_microsecond: int = 0, p_is_utc: bool = false):
	year = p_year
	month = p_month
	day = p_day
	hour = p_hour
	minute = p_minute
	second = p_second
	millisecond = p_millisecond
	microsecond = p_microsecond
	is_utc = p_is_utc
	_update_internal()

# Sync internal vars with exported ones
func _update_internal():
	_year = year
	_month = month
	_day = day
	_hour = hour
	_minute = minute
	_second = second
	_millisecond = millisecond
	_microsecond = microsecond
	_is_utc = is_utc

# Static method: Current local time
static func now() -> DateTime:
	var dict = Time.get_datetime_dict_from_system()
	return DateTime.new(
		dict["year"], dict["month"], dict["day"],
		dict["hour"], dict["minute"], dict["second"],
		0, 0, false
	)

# Static method: Current UTC time
static func utc_now() -> DateTime:
	var dict = Time.get_datetime_dict_from_system(true)
	return DateTime.new(
		dict["year"], dict["month"], dict["day"],
		dict["hour"], dict["minute"], dict["second"],
		0, 0, true
	)

# Static method: UTC constructor
static func utc(p_year: int, p_month: int, p_day: int, p_hour: int = 0, p_minute: int = 0, 
				p_second: int = 0, p_millisecond: int = 0, p_microsecond: int = 0) -> DateTime:
	return DateTime.new(p_year, p_month, p_day, p_hour, p_minute, p_second, p_millisecond, p_microsecond, true)

# Static method: Parse ISO 8601 string
static func parse(iso_string: String) -> DateTime:
	var p_is_utc = iso_string.ends_with("Z")
	var parts = iso_string.replace("Z", "").split("T" if "T" in iso_string else " ")
	if parts.size() < 1:
		push_error("Invalid ISO 8601 format")
		return DateTime.now()
	
	var date_parts = parts[0].split("-")
	var time_parts = parts.size() > 1 if parts[1].split(":") else ["0", "0", "0"] as Array[String]
	
	if date_parts.size() != 3 or time_parts.size() != 3:
		push_error("Invalid ISO 8601 components")
		return DateTime.now()
	
	var p_year = int(date_parts[0])
	var p_month = int(date_parts[1])
	var p_day = int(date_parts[2])
	var p_hour = int(time_parts[0])
	var p_minute = int(time_parts[1])
	var p_second = int(time_parts[2].split(".")[0])
	
	return DateTime.new(p_year, p_month, p_day, p_hour, p_minute, p_second, 0, 0, p_is_utc)

# Read-only properties
var get_year: int:
	get: return _year

var get_month: int:
	get: return _month

var get_day: int:
	get: return _day

var get_hour: int:
	get: return _hour

var get_minute: int:
	get: return _minute

var get_second: int:
	get: return _second

var get_millisecond: int:
	get: return _millisecond

var get_microsecond: int:
	get: return _microsecond

var get_is_utc: bool:
	get: return _is_utc

# Helper: Days in a month
func _days_in_month(p_year: int, p_month: int) -> int:
	match p_month:
		4, 6, 9, 11: return 30
		2: return 28 if not _is_leap_year(p_year) else 29
		_: return 31

# Helper: Leap year check
func _is_leap_year(p_year: int) -> bool:
	return p_year % 4 == 0 and (p_year % 100 != 0 or p_year % 400 == 0)

# Convert to UTC
func to_utc() -> DateTime:
	if _is_utc:
		return self
	var local_dict = {
		"year": _year, "month": _month, "day": _day,
		"hour": _hour, "minute": _minute, "second": _second
	}
	var unix_time = Time.get_unix_time_from_datetime_dict(local_dict)
	var offset = Time.get_time_zone_from_system()["bias"] * 60 # Offset in seconds
	unix_time -= offset
	var adjusted_utc_dict = Time.get_datetime_dict_from_unix_time(unix_time)
	return DateTime.new(
		adjusted_utc_dict["year"], adjusted_utc_dict["month"], adjusted_utc_dict["day"],
		adjusted_utc_dict["hour"], adjusted_utc_dict["minute"], adjusted_utc_dict["second"],
		_millisecond, _microsecond, true
	)

# Convert to local
func to_local() -> DateTime:
	if not _is_utc:
		return self
	var utc_dict = {
		"year": _year, "month": _month, "day": _day,
		"hour": _hour, "minute": _minute, "second": _second
	}
	var unix_time = Time.get_unix_time_from_datetime_dict(utc_dict)
	var offset = Time.get_time_zone_from_system()["bias"] * 60 # Offset in seconds
	unix_time += offset
	var adjusted_local_dict = Time.get_datetime_dict_from_unix_time(unix_time)
	return DateTime.new(
		adjusted_local_dict["year"], adjusted_local_dict["month"], adjusted_local_dict["day"],
		adjusted_local_dict["hour"], adjusted_local_dict["minute"], adjusted_local_dict["second"],
		_millisecond, _microsecond, false
	)

# Add days
func add_days(days: int) -> DateTime:
	var dict = {
		"year": _year, "month": _month, "day": _day,
		"hour": _hour, "minute": _minute, "second": _second
	}
	var unix_time = Time.get_unix_time_from_datetime_dict(dict)
	unix_time += days * 86400
	var new_dict = Time.get_datetime_dict_from_unix_time(unix_time)
	return DateTime.new(
		new_dict["year"], new_dict["month"], new_dict["day"],
		_hour, _minute, _second, _millisecond, _microsecond, _is_utc
	)

# String representation
func to_string_repr() -> String:
	return "%04d-%02d-%02d %02d:%02d:%02d%s" % [
		_year, _month, _day, _hour, _minute, _second,
		"Z" if _is_utc else ""
	]

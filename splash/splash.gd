extends Control
@export var next_scene:PackedScene

@export var delay_before_fade_in := 0.4
@export var fade_in_period := 1.7
@export var between_fades_period := 0.8
@export var fade_out_period := 0.5
var tween:Tween

func _ready() -> void:
	if null == next_scene:
		push_error("ERROR: next_scene is null. Choose using the Inspector tab")
	tween = create_tween()
	tween.tween_interval(delay_before_fade_in)
	tween.tween_property($TextureRect, "modulate:a", 1.0, fade_in_period)
	tween.tween_interval(between_fades_period)
	tween.tween_property($TextureRect, "modulate:a", 0.0, fade_out_period)
	
	await tween.finished
	load_next_scene()

func load_next_scene():
	get_tree().change_scene_to_packed(next_scene)

extends Node2D

const ViewPortTemplate = preload("res://addons/godot_transitions/scenes/ViewPortScene.tscn")
const ZigZagOverlay = preload("res://addons/godot_transitions/scenes/ZigZagOverlay.tscn")
const StripesHorizontal = preload("res://addons/godot_transitions/scenes/StripesHorizontal.tscn")
const Sector = preload("res://addons/godot_transitions/scenes/Sector.tscn")
const Donut = preload("res://addons/godot_transitions/scenes/Donut.tscn")

var SCREEN: Dictionary = {
	"width" :ProjectSettings.get("display/window/size/width"),
	"height": ProjectSettings.get("display/window/size/height"),
	"center": Vector2()
}

func _ready() -> void:
	SCREEN.center = Vector2(SCREEN.width/2, SCREEN.height/2)
	
	print(get_tree().current_scene)

func fade_out(from, to, duration: float, color: Color) -> void:
	var rootControl = CanvasLayer.new()
	var colorRect = ColorRect.new()
	var tween = Tween.new()
	
	colorRect.set_frame_color(Color(0, 0, 0, 0))
	
	get_tree().get_root().add_child(rootControl)
	rootControl.add_child(colorRect)
	rootControl.add_child(tween)
	colorRect._set_size(Vector2(SCREEN.width, SCREEN.height))
	
	tween.interpolate_property(colorRect, "color", Color(0, 0, 0, 0), color, duration/2.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	from.queue_free()
	
	tween.interpolate_property(colorRect, "color", colorRect.get_frame_color(), Color(0, 0, 0, 0), duration/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().set_current_scene(new_scene)
	rootControl.queue_free()

func move_to(from, to, duration: float, dir: Vector2):
	var viewportScene = ViewPortTemplate.instance()
	get_tree().get_root().add_child(viewportScene)
	
	var old_viewport_holder = viewportScene.get_node("OldScene")
	var new_viewport_holder = viewportScene.get_node("NewScene")
	var old_viewport = old_viewport_holder.get_node("Viewport1")
	var new_viewport = new_viewport_holder.get_node("Viewport2")
	var tween = viewportScene.get_node("Tween")
	
	dir.x *= SCREEN.width
	dir.y *= SCREEN.height
	
	from.get_parent().remove_child(from)
	old_viewport.add_child(from)
	
	var new_scene = load(to).instance()
	new_viewport.add_child(new_scene)
	
	new_viewport_holder._set_global_position(dir)
	
	tween.interpolate_property(old_viewport_holder, "rect_global_position", old_viewport_holder.get_global_position(), old_viewport_holder.get_global_position() - dir, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(new_viewport_holder, "rect_global_position", new_viewport_holder.get_global_position(), new_viewport_holder.get_global_position() - dir, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	from.queue_free()
	new_scene.get_parent().remove_child(new_scene)
	get_tree().get_root().add_child(new_scene)
	viewportScene.queue_free()
	new_scene.set_process(true)
	get_tree().set_current_scene(new_scene)

func shrink(from, to, duration: float):
	# Create Nodes
	var controlRoot = CanvasLayer.new()
	var viewport_holder = ViewportContainer.new()
	var viewport = Viewport.new()
	var colorRect = ColorRect.new()
	var tween = Tween.new()
	
	# Set Properties of the created Nodes
	get_tree().get_root().add_child(controlRoot)
	controlRoot.add_child(viewport_holder)
	viewport_holder._set_size(Vector2(SCREEN.width, SCREEN.height))
	viewport_holder.add_child(viewport)
	viewport.set_size(Vector2(SCREEN.width, SCREEN.height))
	from.get_parent().remove_child(from)
	viewport.add_child(from)
	controlRoot.add_child(colorRect)
	colorRect.set_frame_color(Color(0, 0, 0, 0))
	colorRect._set_size(Vector2(SCREEN.width, SCREEN.height))
	controlRoot.add_child(tween)
	
	# Tween Time!
	tween.interpolate_property(viewport_holder, "rect_size", Vector2(SCREEN.width, SCREEN.height), Vector2.ZERO, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(viewport, "size", Vector2(SCREEN.width, SCREEN.height), Vector2.ZERO, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(colorRect, "color", Color(0, 0, 0, 0), Color.black, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_all_completed")
	
	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	
	viewport_holder.queue_free()
	from.queue_free()
	
	tween.interpolate_property(colorRect, "color", Color.black, Color(0, 0, 0, 0), duration/2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().set_current_scene(new_scene)
	controlRoot.queue_free()

func slide_rect(from, to, duration: float, color: Color, dir: Vector2) -> void:
	var controlRoot = CanvasLayer.new()
	var overlay = ZigZagOverlay.instance()
	var tween = Tween.new()
	
	get_tree().get_root().add_child(controlRoot)
	controlRoot.add_child(overlay)
	overlay.color = color
	overlay.global_position = Vector2(0, 0)
	controlRoot.add_child(tween)
	
	tween.interpolate_property(overlay, "global_position", Vector2(-(dir.x * SCREEN.width), 0), Vector2(0, 0), duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
	yield(tween, "tween_all_completed")
	
	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	from.queue_free()
	
	tween.interpolate_property(overlay, "global_position", Vector2(0, 0), Vector2(dir.x * (SCREEN.width + 64), 0), duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().set_current_scene(new_scene)
	controlRoot.queue_free()

func horizontal_stripes(from, to, duration: float, color: Color, delay = 0.5):
	var controlRoot = CanvasLayer.new()
	var overlay_left = StripesHorizontal.instance()
	var overlay_right = StripesHorizontal.instance()
	var tween = Tween.new()
	
	var y_offset = 0
	
	get_tree().get_root().add_child(controlRoot)
	controlRoot.add_child(overlay_left)
	overlay_left.color = color
	overlay_left.global_position = Vector2(-SCREEN.width, 0)
	controlRoot.add_child(overlay_right)
	overlay_right.color = color
	overlay_right.global_position = Vector2(SCREEN.width, y_offset)
	controlRoot.add_child(tween)
	
	y_offset = overlay_right.get_offset_y()
	
	tween.interpolate_property(overlay_left, "global_position", Vector2(-SCREEN.width, 0), Vector2(0, 0), duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(overlay_right, "global_position", Vector2(SCREEN.width, y_offset), Vector2(0, y_offset), duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
	yield(tween, "tween_all_completed")
	
	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	from.queue_free()
	
	yield(get_tree().create_timer(delay), "timeout")
	
	tween.interpolate_property(overlay_left, "global_position", Vector2(0, 0), Vector2(SCREEN.width, 0), duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(overlay_right, "global_position", Vector2(0, y_offset), Vector2(-SCREEN.width, y_offset), duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().set_current_scene(new_scene)
	controlRoot.queue_free()

func dual_circles(from, to, duration: float, color: Color):
	var controlRoot = CanvasLayer.new()
	var overlay_top = Sector.instance()
	var overlay_bottom = Sector.instance()
	var tween = Tween.new()
	
	get_tree().get_root().add_child(controlRoot)
	controlRoot.add_child(overlay_top)
	overlay_top.color = color
	overlay_top.global_position = SCREEN.center
	overlay_top.center = Vector2.ZERO
	overlay_top.angle_from = 90
	overlay_top.angle_to = 90
	overlay_top.radius = SCREEN.center.distance_to(Vector2(SCREEN.width, 0))
	
	controlRoot.add_child(overlay_bottom)
	overlay_bottom.color = color
	overlay_bottom.global_position = SCREEN.center
	overlay_bottom.center = Vector2.ZERO
	overlay_bottom.angle_from = -90
	overlay_bottom.angle_to = -90
	overlay_bottom.radius = SCREEN.center.distance_to(Vector2(SCREEN.width, 0))
	
	controlRoot.add_child(tween)
	
	tween.interpolate_property(overlay_top, "angle_to", 90, -90, duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(overlay_bottom, "angle_to", -90, -270, duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
	yield(tween, "tween_all_completed")
	
	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	from.queue_free()
	
	yield(get_tree().create_timer(0.2), "timeout")

	tween.interpolate_property(overlay_top, "angle_to", -90, 90, duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(overlay_bottom, "angle_to", -270, -90, duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_all_completed")

	get_tree().set_current_scene(new_scene)
	controlRoot.queue_free()

func donut_eye(from, to, duration: float, color: Color):
	var controlRoot = CanvasLayer.new()
	var donut = Donut.instance()
	var tween = Tween.new()
	
	var r = SCREEN.center.distance_to(Vector2(SCREEN.width, 0)) # Screen Diagonal / 2
	
	get_tree().get_root().add_child(controlRoot)
	controlRoot.add_child(donut)
	donut.color = color
	donut.global_position = SCREEN.center
	donut.center = Vector2.ZERO
	donut.inner_radius =  r
	donut.outer_radius =  r + 10
	
	controlRoot.add_child(tween)
	
	tween.interpolate_property(donut, "inner_radius", r, 0, duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
	yield(tween, "tween_all_completed")

	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	from.queue_free()

	yield(get_tree().create_timer(0.2), "timeout")

	tween.interpolate_property(donut, "inner_radius", 0, r, duration/2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_all_completed")
	
	get_tree().set_current_scene(new_scene)
	controlRoot.queue_free()

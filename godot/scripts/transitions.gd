extends Node

const ViewPortTemplate = preload("res://demo/ViewPortScene.tscn")

var SCREEN: Dictionary = {
	"width" :ProjectSettings.get("display/window/size/width"),
	"height": ProjectSettings.get("display/window/size/width")
}

func _ready() -> void:
	pass

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

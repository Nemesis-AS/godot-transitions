tool
extends EditorPlugin

func _enter_tree() -> void:
	if not get_parent() == get_tree().root and self != get_tree().current_scene:
		add_autoload_singleton("Transitions", "res://addons/godot_transitions/transitions.gd")
	
	print("[Godot Transitions] Ready")

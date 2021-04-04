extends Node2D


func _on_Fade_OutIn_pressed() -> void:
	Transitions.fade_out(self, "res://demo/Demo2.tscn", 1.5, Color.black)

func _on_MoveTo_pressed() -> void:
	Transitions.move_to(self, "res://demo/Demo2.tscn", 1.5, Vector2.RIGHT)

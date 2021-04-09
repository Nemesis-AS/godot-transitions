extends Node2D


func _on_Fade_OutIn_pressed() -> void:
	Transitions.fade_out(self, "res://demo/Demo2.tscn", 1.5, Color.black)

func _on_MoveTo_pressed() -> void:
	Transitions.move_to(self, "res://demo/Demo2.tscn", 1.5, Vector2.RIGHT)

func _on_Shrink_pressed() -> void:
	Transitions.shrink(self, "res://demo/Demo2.tscn", 2)

func _on_SlideZag_pressed() -> void:
#	Transitions.horizontal_stripes(self, "res://demo/Demo2.tscn", 2, Color.black)
	Transitions.donut_eye(self, "res://demo/Demo2.tscn", 2, Color.black)

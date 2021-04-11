extends Node2D

export(String, FILE, "*.tscn") var target

func _on_Fade_OutIn_pressed() -> void:
	Transitions.fade_out(self, target, 1.5, Color.black)

func _on_MoveTo_pressed() -> void:
	Transitions.move_to(self, target, 1.5, Vector2.RIGHT)

func _on_Shrink_pressed() -> void:
	Transitions.shrink(self, target, 2)

func _on_SlideZag_pressed() -> void:
	Transitions.slide_rect(self, target, 2, Color.black, Vector2.LEFT)

func _on_HorStripes_pressed() -> void:
	Transitions.horizontal_stripes(self, target, 2, Color.black)

func _on_DualCircles_pressed() -> void:
	Transitions.dual_circles(self, target, 2, Color.black)

func _on_DonutEye_pressed() -> void:
	Transitions.donut_eye(self, target, 2, Color.black)

extends Node2D

func _ready() -> void:
	set_process(true)

func _on_Fade_OutIn_pressed() -> void:
	Transitions.fade_out(self, "res://demo/Demo1.tscn", 1.5, Color.black)

func _on_Move_To_pressed() -> void:
	Transitions.move_to(self, "res://demo/Demo1.tscn", 1.5, Vector2.LEFT)

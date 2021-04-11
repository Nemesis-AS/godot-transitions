extends Node2D

export(int) var stripes = 3
export(Color) var color = Color.white

var points = []
var screen = Transitions.SCREEN
var step

func _ready() -> void:
	step = screen.height / ((stripes - 1) * 2)
	var y = 0
	
	while y <= screen.height:
		points.append(Rect2(0, y, screen.width, step/2))
		y += step

func _draw() -> void:
	for rect in points:
		draw_rect(rect, color, true)

func get_offset_y():
	return step/2

extends Node2D

export(Color) var color = Color.white

var width = Transitions.SCREEN.width
var points = []

func _ready() -> void:
	var temp_array = []
	
	var x = width
	var y = 0
	
	points.append(Vector2(x, y))
	temp_array.append(Vector2(x - (width + 64), y))
	
	while y <= Transitions.SCREEN.height:
		y += 32
		if x <= width:
			x += 32
		else:
			x -= 32
		
		points.append(Vector2(x, y))
		temp_array.append(Vector2(x - (width + 64), y))
	
	temp_array.invert()
	points += temp_array

func _draw() -> void:
	draw_polygon(PoolVector2Array(points), PoolColorArray([color]))

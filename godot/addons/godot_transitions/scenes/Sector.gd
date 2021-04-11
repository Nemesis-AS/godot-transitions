extends Node2D

var center: Vector2 = Vector2(Transitions.SCREEN.width/2, 300)
var radius: float
var angle_from
var angle_to
var color

func _draw():
	draw_circle_arc_poly()

func _process(_delta: float) -> void:
	update()

func draw_circle_arc_poly():
    var nb_points = 32
    var points_arc = PoolVector2Array()
    points_arc.push_back(center)
    var colors = PoolColorArray([color])

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)

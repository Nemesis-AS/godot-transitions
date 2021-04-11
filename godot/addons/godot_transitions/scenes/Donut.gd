extends Node2D

var center: Vector2
var inner_radius: float
var outer_radius: float
var color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = Transitions.SCREEN.center
	inner_radius = 32
	outer_radius = 64
	color = Color.whitesmoke

func _draw() -> void:
	draw_donut()

func _physics_process(_delta: float) -> void:
	update()

func draw_donut():
	var nb_points = 32  
	var points_arc = PoolVector2Array()
	var colors = PoolColorArray([color])  

	for i in range(nb_points+1):  
		var angle_point = i * (360) / nb_points - 90  
		points_arc.push_back(center + Vector2(cos(deg2rad(angle_point)), sin(deg2rad(angle_point))) * outer_radius)  
	for i in range(nb_points,-1,-1):  
		var angle_point = i * (360) / nb_points - 90  
		points_arc.push_back(center + Vector2(cos(deg2rad(angle_point)), sin(deg2rad(angle_point))) * inner_radius)  
		
	draw_polygon(points_arc, colors)  

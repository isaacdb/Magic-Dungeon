extends Polygon2D

## Tentei utilizar, porem não gostei mt
## Alguns objetos que queria fragmentar usam sprite sheets com mais de um fram
## Então isso fica um pouco complicado pra organizar o material aqui no polygon


@export var shard_count := 32
@export var spriteSize := Vector2(16, 16)
@export var frameNum := 0

var shard_velocity_map = {}
var rand_color := false

func _ready():
	randomize()

func Execute():
	Explode()
	pass

func Explode():
	texture_offset.x = frameNum * spriteSize.x
	
	#this will let us add more points to our polygon later on
	var points = polygon
	for i in range(shard_count):
		points.append(Vector2(randi()%(spriteSize.x as int), randi()%(spriteSize.y as int)))	
	
	var delaunay_points = Geometry2D.triangulate_delaunay(points)
	
#	if !delaunay_points:
#		print("serious error occurred no delaunay points found")
	
	#loop over each returned triangle
	for index in len(delaunay_points) / 3:
		var shard_pool = PackedVector2Array()
		#find the center of our triangle
		var center = Vector2.ZERO
		
		# loop over the three points in our triangle
		for n in range(3):
			shard_pool.append(points[delaunay_points[(index * 3) + n]])
			center += points[delaunay_points[(index * 3) + n]]
			
		# adding all the points and dividing by the number of points gets the mean position
		center /= 3
		
		#create a new polygon to give these points to
		
		var shard = Polygon2D.new()
		shard.polygon = shard_pool
		
		if rand_color:
			shard.color = Color(randf(), randf(), randf(), 1)
		else:
			shard.texture = texture
			
		shard_velocity_map[shard] = spriteSize - center #position relative to center of sprite
			
			
		add_child(shard)
		
	#this will make our base sprite invisible
	color.a = 0
	
func _process(delta):
	return 
	#we wan't to chuck our traingles out from the center of the parent
	for child in shard_velocity_map.keys():
		child.position -= shard_velocity_map[child] * delta * 2
		child.rotation -= shard_velocity_map[child].x * delta * 0.1
		#apply gravity to the velocity map so the triangle falls
		shard_velocity_map[child].y -= delta * 10
		
func _input(event):
	if Input.get_action_strength("ui_accept"):
		Explode()

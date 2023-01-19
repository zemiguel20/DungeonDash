extends Node2D

export var speed: float = 300

var ground_chunks: Array
var background_chunks: Array

var ground_size: Vector2
var background_size: Vector2

func _ready():
	ground_size = calculate_size($GroundCeiling)
	background_size = calculate_size($Background)
	print(ground_size)
	print(background_size)
	
	ground_chunks = [$GroundCeiling, $GroundCeiling2]
	background_chunks = [$Background, $Background2]

func calculate_size(tilemap: TileMap) -> Vector2:
	var rect = tilemap.get_used_rect()
	var size = rect.size * tilemap.cell_size * tilemap.scale
	return size

func _process(delta):
	# Move
	ground_chunks[0].position.x -= speed * delta
	ground_chunks[1].position.x -= speed * delta
	background_chunks[0].position.x -= speed * delta
	background_chunks[1].position.x -= speed * delta
	
func _on_background_screen_exited():
	var chunk = background_chunks.pop_front()
	chunk.position = background_chunks.front().position + Vector2(background_size.x, 0)
	background_chunks.append(chunk)

func _on_ground_screen_exited():
	var chunk = ground_chunks.pop_front()
	chunk.position = ground_chunks.front().position + Vector2(ground_size.x, 0)
	ground_chunks.append(chunk)

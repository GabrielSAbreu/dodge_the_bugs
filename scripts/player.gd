extends Area2D

signal hit
const SPEED := 400 # : significa que somente serão aceitos números inteiros
var screen_size
@onready var anim = $anim
@onready var colision = $colision
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		
	if velocity.x != 0:
		anim.play("move")
	elif velocity.y > 0:
		anim.play("move_up")
	elif  velocity.y < 0:
		anim.play("move_down")
	else:
		anim.play("idle")
		
	if velocity.x > 0:
		anim.flip_h = true
	else:
		anim.flip_h = false
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

#Verificação de colisão
func _on_body_entered(body):
	hide()
	hit.emit()
	colision.set_deferred("disabled",true)
	
func start_pos(pos):
	position = pos
	show()
	colision.disabled = false

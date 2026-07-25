extends Camera2D

@export var recoil_return_speed := 5.0

var recoil_offset := Vector2.ZERO
var target_offset := Vector2.ZERO  

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(50, 35)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var shake_intensity = 0.0  # Current shake strength.

var debug = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameGlobals.shake_camera.connect(add_shake)

func _process(delta):
	if shake_intensity:
		shake_intensity = max(shake_intensity - decay * delta, 0)
		shake()
	
	recoil_offset = recoil_offset.lerp(Vector2.ZERO, recoil_return_speed * delta)
	self.position = recoil_offset

func recoil(angle_radians: float, intensity: float):
	#var angle_radians = deg_to_rad(angle_degrees)
	var direction = Vector2(0, -1).rotated(angle_radians - PI).normalized()
	target_offset = direction * intensity
	recoil_offset += target_offset  # Aplica el desplazamiento del retroceso

func shake():
	var rng = RandomNumberGenerator.new()
	var amount = pow(shake_intensity, 3)
	rotation = max_roll * amount  * rng.randf_range(-1, 1)
	offset.x = max_offset.x * amount * rng.randf_range(-1, 1)
	offset.y = max_offset.y * amount * rng.randf_range(-1, 1)

func add_shake(amount : float = 0.65):
	shake_intensity = min(shake_intensity + amount, 1.0)
	

func _input(event):
	pass

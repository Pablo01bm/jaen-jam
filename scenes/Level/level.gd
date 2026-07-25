extends Node2D
class_name Level

## Emitido cuando los 3 hijoputas han sido dedeados
signal level_completed


@export var HIJOPUTA_COUNT := 1
const MAX_REROLL_TRIES := 30

@export var velocidad: float = 150.0

var m_aliens: Array[Alien] = []
var m_hijoputas: Array[Alien] = []

var started = false


func _ready() -> void:
	_collect_aliens()
	_generate_hijoputas()
	GameManager.register_level(self)
	_assign_z_index()
	GameGlobals.is_closed.connect(_start_timer)
	$Timer.timeout.connect(_game_over)
	$TimeLeft.text = str($Timer.wait_time)
	GameGlobals.is_closed.connect(func(): started = true)

func _process(delta):
	if started:
		$TimeLeft.text = str($Timer.time_left)

func _collect_aliens() -> void:
	m_aliens.clear()
	for child in $Aliens.get_children():
		if child is Alien:
			m_aliens.append(child)
			child.died.connect(_on_alien_died)


func _generate_hijoputas() -> void:
	m_hijoputas.clear()
	
	print( m_aliens.size())
	if m_aliens.size() < HIJOPUTA_COUNT:
		push_warning("Level: no hay suficientes alienigenas puteros para elegir %d hijoputas" % HIJOPUTA_COUNT)
		return
	print("GENERANDO MAMAHUEVOS")
	var candidates := m_aliens.duplicate()
	candidates.shuffle()
	
	for i in range(HIJOPUTA_COUNT):
		var alien: Alien = candidates[i]
		alien.set_hijoputa(true)
		m_hijoputas.append(alien)
	
	# Una vez decididos los 3 pues que no se parezcan manin
	for hijoputa in m_hijoputas:
		_ensure_unique_face(hijoputa)
		# Actualizamos las caras usando globals
		GameGlobals.alien_motherfuckers.append(hijoputa)
	
	
	$WantedList._update_alien_faces()


func _ensure_unique_face(alien: Alien) -> void:
	var tries := 0
	while _face_collides(alien) and tries < MAX_REROLL_TRIES:
		alien.reroll_features()
		tries += 1
	
	if tries >= MAX_REROLL_TRIES:
		push_warning("Level: no se pudo generar una cara única para %s tras %d intentos" % [alien.name, MAX_REROLL_TRIES])


func _face_collides(alien: Alien) -> bool:
	for other in m_aliens:
		if other == alien:
			continue
		if alien.has_same_face_as(other):
			return true
	return false


func _on_alien_died(alien: Alien) -> void:
	if not alien.is_hijoputa:
		return

	m_hijoputas.erase(alien)
	if m_hijoputas.is_empty():
		_check_victory()


func _check_victory() -> void:
	level_completed.emit()
	GameGlobals.score += ($Timer.wait_time - $Timer.time_left)
	$Timer.stop()
	

func _game_over() -> void:
	$Timer.stop()
	GameGlobals.alien_motherfuckers.clear()
	GameManager.game_over()

func _assign_z_index() -> void:
	var aliensNode = get_node("Aliens")
	var i = 0
	for childAlien in aliensNode.get_children():
		childAlien.z_index = i
		i+=1

func _start_timer() -> void:
	if $Timer.time_left == 0:
		$Timer.start()

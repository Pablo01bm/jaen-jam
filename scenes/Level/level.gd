extends Node2D
class_name Level

## Emitido cuando los 3 hijoputas han sido dedeados
signal level_completed

const HIJOPUTA_COUNT := 3
const MAX_REROLL_TRIES := 30

@export var velocidad: float = 150.0

var m_aliens: Array[Alien] = []
var m_hijoputas: Array[Alien] = []


func _ready() -> void:
	_collect_aliens()
	_generate_hijoputas()
	GameManager.register_level(self)
	_assign_z_index()


func _collect_aliens() -> void:
	m_aliens.clear()
	for child in get_children():
		if child is Alien:
			m_aliens.append(child)
			child.died.connect(_on_alien_died)


func _generate_hijoputas() -> void:
	print("GENERANDO MAMAHUEVOS")
	m_hijoputas.clear()

	if m_aliens.size() < HIJOPUTA_COUNT:
		push_warning("Level: no hay suficientes alienigenas puteros para elegir %d hijoputas" % HIJOPUTA_COUNT)
		return

	var candidates := m_aliens.duplicate()
	candidates.shuffle()

	for i in range(HIJOPUTA_COUNT):
		var alien: Alien = candidates[i]
		alien.set_hijoputa(true)
		m_hijoputas.append(alien)

	# Una vez decididos los 3 pues que no se parezcan manin
	for hijoputa in m_hijoputas:
		_ensure_unique_face(hijoputa)

# Este metodo cogelo con pinzas, hice lo que pude
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

func _assign_z_index() -> void:
	var aliensNode = get_node("Aliens")
	var i = 0
	for childAlien in aliensNode.get_children():
		childAlien.z_index = i
		i+=1

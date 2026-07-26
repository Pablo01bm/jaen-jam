extends Level
class_name LevelE

var boss = null
var is_boss = false

func _ready() -> void:
	GameGlobals.level_started.emit()
	_collect_aliens()
	_generate_hijoputas()
	GameManager.register_level(self)
	_assign_z_index()
	GameGlobals.is_closed.connect(_start_timer)
	$Timer.timeout.connect(_game_over)
	$TimeLeft.text = str($Timer.wait_time)
	GameGlobals.is_closed.connect(func(): started = true)
	$FinishTimer.timeout.connect(finish)

func _process(delta):
	if started:
		$TimeLeft.text = str(snapped($Timer.time_left, 0.1))

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
	GameGlobals.alien_motherfuckers_faces.append(alien.get_face_signature())
	
	m_hijoputas.erase(alien)
	if m_hijoputas.is_empty():
		_check_victory()


func _check_victory() -> void:
	if is_boss == false:
		$Timer.paused = true
		$AnimationPlayer.play("boss")
		GameGlobals.level_finished.emit()
	else:
		GameGlobals.score += ($Timer.wait_time - $Timer.time_left)
		$Timer.paused = true
		$FinishTimer.start()
		GameGlobals.level_finished.emit()
		$Curtain.curtain_down()

func finish():
	if $Timer.time_left > 0:
		level_completed.emit()
	else:
		GameGlobals.alien_motherfuckers.clear()
		GameManager.game_over()


func _game_over() -> void:
	$Timer.stop()
	$FinishTimer.start()
	$Curtain.curtain_down()
	GameGlobals.level_finished.emit()

func _assign_z_index() -> void:
	var aliensNode = get_node("Aliens")
	var i = 0
	for childAlien in aliensNode.get_children():
		childAlien.z_index = i
		i+=1

func _start_timer() -> void:
	if $Timer.time_left == 0:
		$Timer.start()
		$TimeLeft/AnimationPlayer.play("tictac")


func spawn_boss():
	var b = preload("res://scenes/Alien/BossAlien.tscn").instantiate()
	b.global_position = $House/Marker2D.global_position
	add_child(b)
	boss = b
	boss.z_index = 0
	is_boss = true
	$Timer.paused = false
	GameGlobals.boss_appeared.emit()
	boss.killed.connect(_check_victory)

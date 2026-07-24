extends State
class_name GameState

var TITLE_SCREEN = "TitleScreenState"
var GAMEPLAY = "GameplayState"
var GAME_OVER = "GameOverState"
var GAME_COMPLETED = "GameCompletedState"

var game: Game

func _ready() -> void:
	await owner.ready
	game = owner as Game
	assert(game != null, "The GameState state type must be used only in the game scene. It needs the owner to be a Game node.")

extends Node
class_name CrimeGenerator

const CRIMES := {
	"es": {
		"names": ["Manolo", "Ragoy", "Elsapato", "Pene Penez", "Mariuzz Bross", "Weón", "Marciano Rajoy", "Lambdas", "Diganmas", "Xokulon", "Kang", "Kodos", "E.T.", "Goku", "Glorbo", "Citripio", "Gluppo", "Jabba", "Nappa", "Mr. Penis", "Pavro", "Pablo Matón", "Pepe", "Bimbo"],
		"actions": [
			{"text": "robó"},
			{"text": "secuestró"},
			{"text": "quemó"},
			{"text": "dedeó"},
			{"text": "desintegró"},
			{"text": "instaló linux", "preposition": "en"},
			{"text": "joseó"},
			{"text": "lamió"},
			{"text": "se comió"},
			{"text": "aparcó"},
			{"text": "insultó"},
			{"text": "larpeó"},
			{"text": "mató"},
			{"text": "olió"},
			{"text": "besó"},
			{"text": "hackeó la DSi", "preposition": "a"},
			{"text": "invitó a café", "preposition": "a"},
			{"text": "se montó", "preposition": "en"},
			{"text": "se bebió"},
			
		],
		"objects": [
			{"noun": "una abuelita", "personal": true},
			{"noun": "el glob-glab del vecino", "personal": true},
			{"noun": "el bote de frijoles del Alcalde", "personal": false},
			{"noun": "Jorge", "personal": true},
			{"noun": "la colección de lápices de Kevin", "personal": false},
			{"noun": "una puerta"},
			{"noun": "una tarjeta gráfica"},
			{"noun": "una steam machine"},
			{"noun": "un seis y un siete"},
			{"noun": "tu prima", "personal": true},
			{"noun": "la provincia de Jaén en su totalidad", "personal": true},
			{"noun": "un chicle"},
			{"noun": "la fruta del roscón de reyes"},
			{"noun": "un salmorejo"},
			{"noun": "quinientas hectáreas de olivos"},
			{"noun": "Goku", "personal": true},
			{"noun": "lo blanco del jamón"},
			{"noun": "la Jaén jam"},
			{"noun": "Chiquito de la Calzada", "personal": true},
			{"noun": "el pentágono"},
			{"noun": "Mikel Oyarzabal", "personal": true},
			{"noun": "los juegos físicos"},
			{"noun": "el Guadalindie"},
			{"noun": "el pan Bimbo"},





		],
	},
	"en": {
		"names": ["Manolo", "Ragoy", "Elsapato", "Marciano Rajoy", "Lambdas", "Diganmas", "Xokulon", "Kang", "Kodos", "E.T.", "Goku", "Glorbo", "Citripio", "Gluppo", "Mr. Penis", "Pavro", "Pablo Matón", "Pepe"],
		"actions": [
			{"text": "stole"},
			{"text": "kidnapped"},
			{"text": "incinerated"},
			{"text": "fingered"},
			{"text": "disintegrated"},
			{"text": "installed linux", "preposition": "in"},
		],
		"objects": [
			{"noun": "a granny"},
			{"noun": "the neighbour's glob-glab"},
			{"noun": "the mayor's can of beans"},
			{"noun": "George"},
		],
	},
}

static func _generate_name(lang: String = "es") -> String:
	var data: Dictionary = CRIMES.get(lang, CRIMES["es"])
	var name: String = data["names"].pick_random()
	return name


static func generate_crime(lang: String = "es", index: int = 0) -> String:
	var data: Dictionary = CRIMES.get(lang, CRIMES["es"])
 
	var name: String = GameGlobals.alien_motherfuckers_names.get(index)
	var action: Dictionary = data["actions"].pick_random()
	var object: Dictionary = data["objects"].pick_random()
 
	var phrase: String = _build_object_phrase(object, action.get("preposition", ""), lang)
	return "%s %s %s" % [name, action["text"], phrase]
 
 
static func _build_object_phrase(object: Dictionary, preposition_override: String, lang: String) -> String:
	var noun: String = object["noun"]
 
	if preposition_override != "":
		return "%s %s" % [preposition_override, noun]
 
	if lang == "es" and object.get("personal", false):
		return _with_personal_a(noun)
 
	return noun
 
 
static func _with_personal_a(noun: String) -> String:
	if noun.begins_with("el "):
		return "al " + noun.substr(3)
	return "a " + noun

extends Node
class_name CrimeGenerator

const CRIMES := {
	"es": {
		"names": ["Manolo", "Ragoy", "Elsapato", "Pene Penez", "Mariuzz Bross", "Weón"],
		"actions": [
			{"text": "robó"},
			{"text": "secuestró"},
			{"text": "quemó"},
			{"text": "dedeó"},
			{"text": "desintegró"},
			{"text": "instaló linux", "preposition": "en"},
			{"text": "joseó"},
			{"text": "lamió"}
		],
		"objects": [
			{"noun": "una abuelita", "personal": true},
			{"noun": "el glob-glab del vecino", "personal": true},
			{"noun": "el bote de frijoles del Alcalde", "personal": false},
			{"noun": "Jorge", "personal": true},
			{"noun": "la colección de lápices de Kevin", "personal": false},
			{"noun": "una puerta"}
		],
	},
	"en": {
		"names": ["Manolo", "Ragoy", "Elsapato"],
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

static func generate_crime(lang: String = "es") -> String:
	var data: Dictionary = CRIMES.get(lang, CRIMES["es"])
 
	var name: String = data["names"].pick_random()
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

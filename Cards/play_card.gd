extends MarginContainer

@export var cardName = "CommonRaven";
@onready var birdName: String;
@onready var latinName: String;
@onready var eggSpots: int;
@onready var wingspan: int;
@onready var points: int;
@onready var food: Dictionary;
@onready var habitats: Array = [];
@onready var nest: NestType;

enum FoodType {RAT, FRUIT, INSECT, GRAIN, FISH, ANY}
enum Habitat {FOREST, GRASSLANDS, WETLANDS}
enum NestType {CAVITY, PLATFORM, BOWL, GROUND, ANY, NONE}

# Called when the node enters the scene tree for the first time.
func _ready():
	var filePath = "res://Cards/Collection/" + cardName + ".json"
	parseData(filePath);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func parseData(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	var data = json.get_data() as Dictionary;
	birdName = data["name"]
	latinName = data["latinName"]
	eggSpots = data["eggSpots"]
	habitats = data["habitats"]
	wingspan = data["wingspan"]
	parseNest(data["nest"])
	
func parseFood(foodData):
	for foodType in FoodType:
		var f = foodType.to_lower();
		if foodData.has(f):
			food[foodType] = foodData[f]
	
func checkIfHasHabitat(habitat: Habitat):
	var habitatString = Habitat.keys()[habitat].to_pascal_case();
	return habitats.has(habitatString);
	
func parseNest(nestData):
	nest = NestType.keys().find(nestData.to_upper());
	print(nest)
	

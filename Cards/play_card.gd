extends MarginContainer

@export var cardName = "CommonRaven";
@onready var birdName: String;
@onready var latinName: String;
@onready var eggSpots: int;
@onready var wingspan: int;
@onready var points: int;
@onready var food: Dictionary;
@onready var habitats: Array = [];
@onready var nest: Enums.NestType;

# Called when the node enters the scene tree for the first time.
func _ready():
	var filePath = "res://Cards/Collection/" + cardName + ".json"
	parseData(filePath);
	setLabels()

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
	parseFood(data["food"])
	
func parseFood(foodData):
	for foodType in Enums.FoodType:
		var f = foodType.to_lower();
		if foodData.has(f):
			food[foodType] = foodData[f]
	
func checkIfHasHabitat(habitat: Enums.Habitat):
	var habitatString = Enums.Habitat.keys()[habitat].to_pascal_case();
	return habitats.has(habitatString);
	
func parseNest(nestData):
	nest = Enums.NestType.keys().find(nestData.to_upper());
	
func getFood(foodType: Enums.FoodType):
	var foodString = Enums.FoodType.keys()[foodType];
	if food.has(foodString):
		return food[foodString];
	else:
		return 0
		
func setLabels():
	get_node("NameLabel").text = birdName
	

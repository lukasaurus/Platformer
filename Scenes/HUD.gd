extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.update_score.connect(update_score)
	GameManager.update_lives.connect(update_lives)
	update_score()
	update_lives()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score():
	$PanelContainer/HBoxContainer2/ScoreValue.text = "x "+str(GameManager.score)
	
func update_lives():
	$PanelContainer/HBoxContainer2/HeartValue.text = "x "+str(GameManager.lives)

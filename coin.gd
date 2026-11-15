extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.score += 10

		var score_label = body.get_node("Ui board/ScoreLabel")
		score_label.text = "Score: " + str(body.score)

		get_parent().queue_free()

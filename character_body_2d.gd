
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const FALL_Y = 800.0

var score = 0

@export var fall_limit: float = 1000.0

@onready var start_position: Vector2 = global_position
@onready var game_over_layer = get_tree().current_scene.get_node("GameOverLayer")
@onready var score_label: Label = $"Ui board/ScoreLabel"

var game_over := false


func _ready() -> void:
	score_label.text = "Score: 0"


func _physics_process(delta: float) -> void:
	if game_over:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Player movement
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Check if player falls
	if global_position.y > FALL_Y:
		show_game_over()
		return


# Coin score system
func add_score(points: int) -> void:
	score += points
	score_label.text = "Score: " + str(score)


# Finish line
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../You win".visible = true
		game_over = true
		velocity = Vector2.ZERO


# Game over
func show_game_over() -> void:
	game_over = true
	velocity = Vector2.ZERO
	game_over_layer.visible = true


# Restart button
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


# Main menu button
func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://STARTIING PG.tscn")

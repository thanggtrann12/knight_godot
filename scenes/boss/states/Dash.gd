extends State
@onready var dash_hit_box = $DashHitBox

var can_transition: bool = false
const DASH_DAMAGE: int = 20


func enter():
	super.enter()
	animation_player.play("glowing")
	await dash()
	can_transition = true
 
func dash():
	var tween = create_tween()
	dash_hit_box.get_child(0).set_disabled(false)
	tween.tween_property(owner, "position", player.position, 0.6)
	await tween.finished
	dash_hit_box.get_child(0).set_disabled(true)

func transition():
	if can_transition:
		can_transition = false
 
		get_parent().change_state("Follow")


func _on_dash_hit_box_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(DASH_DAMAGE)

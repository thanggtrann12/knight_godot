extends State
 
@onready var pivot = $"../../Pivot"
@onready var laser_hit_box = $LaserHitBox

var can_transition: bool = false
var enable_laser_hit_box: bool = false

const LASER_DAMAGE: int = 50

func enter():
	super.enter()
	laser_hit_box.get_child(0).set_disabled(true)
	await play_animation("laser_cast")
	await play_animation("laser")
	can_transition = true
	
 
func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished
	laser_hit_box.get_child(0).set_disabled(true)
 
func set_target():
	pivot.rotation = (owner.direction - pivot.position).angle()
	laser_hit_box.rotation = pivot.rotation
	laser_hit_box.get_child(0).set_disabled(false)
	

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")


func _on_laser_hit_box_body_entered(body):
	body.take_damage(LASER_DAMAGE)

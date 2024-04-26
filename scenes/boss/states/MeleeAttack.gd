extends State
@onready var left_arm = $"../../HitBox/left_arm"
@onready var right_arm = $"../../HitBox/right_arm"
@onready var isattack: bool = false

const MELEE_DAMAGE: int = 30

func enter():
	super.enter()
	left_arm.visible = true
	right_arm.visible = true
	animation_player.play("melee_attack")
	await animation_player.animation_finished
 
func transition():
	if owner.direction.length() > 30:
		get_parent().change_state("Follow")
 
func attacking():
	isattack = true
	var overlappingAreas
	if owner.sprite.is_flipped_h() == true:
		overlappingAreas = right_arm.get_parent().get_overlapping_areas()
	else:
		overlappingAreas = left_arm.get_parent().get_overlapping_areas()
	for overlappingArea in overlappingAreas:
		var player_node = overlappingArea.get_owner()
		if player_node:
			player_node.take_damage(MELEE_DAMAGE)

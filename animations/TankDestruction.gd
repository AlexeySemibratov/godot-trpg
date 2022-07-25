extends Node2D

onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var body = $Body

var anims = [
	"explosion 1",
	"explosion 2",
]

func _ready():
	body.get_node("Tracks").playing = false

func start_animation():
	timer.connect("timeout", self, "queue_free")
	timer.start()
	animation.play(_get_random_animation())
	
func _get_random_animation():
	return anims[randi() % anims.size()]

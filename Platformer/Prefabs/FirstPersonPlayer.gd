extends KinematicBody


export var MaxMoveSpeed = 10;
export var Acceleration = 5;
export var groundFriction = 10;

var UpAxisSpeed = 0;
var ForwardSpeed = 0;
var Strafespeed = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func MoveCharacter():
	if(is_on_floor()):
		
		pass	
	pass

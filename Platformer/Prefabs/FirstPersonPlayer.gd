extends KinematicBody


export var MaxMoveSpeed = 10;
export var Acceleration = 5;
export var groundFriction = 10;

export var turnSpeed = 2;

var UpAxisSpeed = 0;
var ForwardSpeed = 0;
var Strafespeed = 0;


var mouseX = 0;
var mouseY = 0;

var forwardAxis;
var rightAxis;
var axis;
onready var cam = $Camera;

var lastMousePos;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	getInputs();
	MoveCharacter(delta);
	pass

func MoveCharacter(var delta):
	if(!is_on_floor()):
		UpAxisSpeed -= 18*delta;
	else:
		UpAxisSpeed = 0;
		if(Input.action_press("Jump")):
			translate(Vector3(0, 20, 0))
			UpAxisSpeed += 200;
		pass
	
	
	rotate_y(mouseX*delta*turnSpeed)
	cam.rotate_x(mouseY*delta*turnSpeed)
	var rot = cam.rotation_degrees;
	rot.x = clamp(rot.x, -70, 70);
	cam.rotation_degrees = rot;
	var moveVec = (transform.basis.z*axis.y*MaxMoveSpeed) + (transform.basis.x*axis.x*MaxMoveSpeed) + (Vector3(0, UpAxisSpeed, 0));
	move_and_slide(moveVec, Vector3(0, 1, 0), false, 4, .9, true);
	pass

func getInputs():
	
	#mouseX = -Input.get_joy_axis(0, 2);
	#if(abs(mouseX) < .2):
		#mouseX = 0;
	#mouseY = -Input.get_joy_axis(0, 3);
	#if(abs(mouseY) < .2):
		#mouseY = 0
	forwardAxis = Input.get_joy_axis(0, 1) + (Input.get_action_strength("moveForward") - Input.get_action_strength("moveBackwards"));
	if(abs(forwardAxis) < .2):
		forwardAxis = 0;
	rightAxis = Input.get_joy_axis(0, 0) + (Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"));
	if(abs(rightAxis)<.2):
		rightAxis = 0;
	axis = Vector2(rightAxis, forwardAxis)
	axis.clamped(1);
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		mouseX = event.speed.x*.01;
		mouseY = event.speed.y*.01;
		pass
	pass

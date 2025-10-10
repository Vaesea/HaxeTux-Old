package;

// Tutorials Used:
// https://www.youtube.com/watch?v=Qdq-vXt-NOE
// https://www.youtube.com/watch?v=aQazVHDztsg and yes i know this is for godot but it was actually helpful for this

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import flixel.util.FlxDirectionFlags;

class Tux extends FlxSprite
{
    // Speed
    var walkSpeed = 230;
    var speed = 0; // DON'T CHANGE THIS. You should only change walkSpeed and runSpeed.
    var runSpeed = 320;

    // Jump stuff and Gravity
    var jumpHeight = 576;
    var gravity = 800;
    var decelerateOnJumpRelease = 0.5; // thanks godot tutorial that i used

    // Images
    var smallImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/smalltux.png", "assets/images/characters/tux/smalltux.xml");
    var bigImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/tux.png", "assets/images/characters/tux/tux.xml");
    var fireImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/firetux.png", "assets/images/characters/tux/firetux.xml");
    
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);
        makeGraphic(32, 32, FlxColor.WHITE);
        drag.x = 1200;
        acceleration.y = gravity;
    }

	override public function update(elapsed:Float)
	{
        // these will have to be changed if options are added that would allow the player to change keybinds or whatever it's called
        // Left + A = Go Left, Right + D = Go Right, Control = Run, Down + S = Duck (NOT ADDED YET!!!), Space + Up + W = Jump
        // movement stuff here because of stupid elapsed:float thing that's needed for variable jump height i think
        if (FlxG.keys.anyPressed([CONTROL]))
        {
            speed = runSpeed;
        }
        else 
        {
            speed = walkSpeed;
        }
        if (FlxG.keys.anyPressed([LEFT, A]) && !FlxG.keys.anyPressed([RIGHT, D]))
        {
            velocity.x = -speed;
        }
        if (FlxG.keys.anyPressed([RIGHT, D]) && !FlxG.keys.anyPressed([LEFT, A]))
        {
            velocity.x = speed;
        }
        if (FlxG.keys.anyPressed([SPACE, UP, W]) && isTouching(FlxDirectionFlags.FLOOR))
        {
            velocity.y = -jumpHeight;
        }
        if (FlxG.keys.anyJustReleased([SPACE, UP, W]) && velocity.y < 0)
        {
            velocity.y = decelerateOnJumpRelease;
        }
		super.update(elapsed);
	}
}
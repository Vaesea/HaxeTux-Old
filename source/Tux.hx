package;

// Tutorials Used:
// https://www.youtube.com/watch?v=Qdq-vXt-NOE

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
    var runSpeed = 320;

    // Jump stuff and Gravity
    var jumpHeight = 576;
    var gravity = 800;

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

    function movement()
    {
        // these will have to be changed if options are added that would allow the player to change keybinds or whatever it's called
        // Left + A = Go Left, Right + D = Go Right, Control = Run, Down + S = Duck (NOT ADDED YET!!!), Space + Up + W = Jump
        if (FlxG.keys.anyPressed([LEFT, A]) && !FlxG.keys.anyPressed([CONTROL, RIGHT, D, DOWN, S]))
        {
            velocity.x = -walkSpeed;
        }
        if (FlxG.keys.anyPressed([RIGHT, D]) && !FlxG.keys.anyPressed([CONTROL, LEFT, A, DOWN, S]))
        {
            velocity.x = walkSpeed;
        }
        if (FlxG.keys.anyPressed([SPACE, UP, W]) && isTouching(FlxDirectionFlags.FLOOR))
        {
            velocity.y = -jumpHeight;
        }
    }

	override public function update(elapsed:Float)
	{
        movement();
		super.update(elapsed);
	}
}
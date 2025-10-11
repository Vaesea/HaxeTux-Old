package;

// Tutorials Used:
// https://www.youtube.com/watch?v=Qdq-vXt-NOE
// https://www.youtube.com/watch?v=aQazVHDztsg and yes i know this is for godot but it was actually helpful for this

// I added lots of comments just in case someone wanted to do make a mod of this recreation but doesn't know how to code.

import flixel.FlxG;
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
    var jumpHeight = 576; // Jump Height
    var gravity = 800; // Gravity, I don't recommend changing this but you can if you want low gravity or high gravity.
    var decelerateOnJumpRelease = 0.5; // thanks godot tutorial that i used. also dont change this

    // Image, if replaced, make sure the replacement image has the same animations!
    var tuxImage = FlxAtlasFrames.fromSparrow("assets/images/characters/tux/smalltux.png", "assets/images/characters/tux/smalltux.xml");

    // You probably shouldn't change any of the below if you're making a mod.
    public function new(x:Float = 0, y:Float = 0)
    {
        super(x, y);
        
        drag.x = 2400; // Add Deceleration
        acceleration.y = gravity; // Add Gravity

        // XML Spritesheet stuff, thanks Friday Night Funkin'
        frames = tuxImage;
        animation.addByPrefix('stand', 'stand', 6, false);
        animation.addByPrefix('walk', 'walk', 6, true);
        animation.play('stand');
    }

	override public function update(elapsed:Float)
	{
        // these will have to be changed if options are added that would allow the player to change keybinds or whatever it's called
        // Left + A = Go Left, Right + D = Go Right, Control = Run, Down + S = Duck (NOT ADDED YET!!!), Space + Up + W = Jump
        // i was gonna use the official haxeflixel way of doing variable jumping (using elapsed:float stuff) so that's why movement stuff is here. might still use it if the godot tutorial method turns out to not work that well for this, so don't move any of this stuff yet!

        // Animation Stuff
        if (velocity.x == 0)
        {
            animation.play('stand');
        }
        if (velocity.x != 0 && touching != WALL)
        {
            animation.play('walk');
        }
        if (velocity.x > 0)
        {
            flipX = false;
        }
        else if (velocity.x < 0)
        {
            flipX = true;
        }

        // Stuff to move Tux
        if (FlxG.keys.anyPressed([CONTROL])) // Running
        {
            speed = runSpeed;
        }
        else 
        {
            speed = walkSpeed;
        }
        if (FlxG.keys.anyPressed([LEFT, A]) && !FlxG.keys.anyPressed([RIGHT, D])) // Moving Left
        {
            velocity.x = -speed;
        }
        if (FlxG.keys.anyPressed([RIGHT, D]) && !FlxG.keys.anyPressed([LEFT, A])) // Moving Right
        {
            velocity.x = speed;
        }
        if (FlxG.keys.anyPressed([SPACE, UP, W]) && isTouching(FlxDirectionFlags.FLOOR)) // Jumping
        {
            velocity.y = -jumpHeight;
        }
        if (FlxG.keys.anyJustReleased([SPACE, UP, W]) && velocity.y < 0) // Variable Jump Height Stuff
        {
            velocity.y = decelerateOnJumpRelease;
        }

		super.update(elapsed); // Put this after the movement code, should probably also be after everything else in update.
	}
}
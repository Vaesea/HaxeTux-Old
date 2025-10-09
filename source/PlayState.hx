package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;

class PlayState extends FlxState
{
	var tux:Tux;
	var levelBounds:FlxGroup; // temporary

	override public function create()
	{
		super.create();

		// Add Tux
		tux = new Tux(20, 20);
		add(tux);

		// Add levelBounds (TEMPORARY)
		levelBounds = FlxCollision.createCameraWall(FlxG.camera, false, 1);
		add(levelBounds);
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(tux, levelBounds);
		super.update(elapsed);
	}
}

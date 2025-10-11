package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	// You probably shouldn't change these if you're modding.
	var tux:Tux;
	var map:FlxOgmo3Loader;
	var levelBounds:FlxGroup; // temporary

	// Changing these is alright if you wanna do something like removing a layer or adding a layer.
	var Foreground:FlxTilemap;
	var Interactive:FlxTilemap;
	var Background:FlxTilemap;
	var PoleTiles:FlxTilemap;

	override public function create()
	{
		super.create();

		map = new FlxOgmo3Loader('assets/data/haxetux.ogmo', 'assets/data/levels/test.json');
		Foreground = map.loadTilemap('assets/images/normalTiles.png', 'Foreground');
		Interactive = map.loadTilemap('assets/images/normalTiles.png', 'Interactive');
		Background = map.loadTilemap('assets/images/normalTiles.png', 'Background');
		PoleTiles = map.loadTilemap('assets/images/poleTiles.png', 'PoleTiles');
		Interactive.follow();

		// Only touch if you've added new tiles.
		// TODO: Better way to do this? I did try not putting the collisionless tiles here.
		Interactive.setTileProperties(1, ANY); // Snow Left
		Interactive.setTileProperties(2, ANY); // Snow Middle
		Interactive.setTileProperties(3, ANY); // Snow Right
		Interactive.setTileProperties(4, ANY); // Snow Bottom
		Interactive.setTileProperties(6, ANY); // Darkstone Left
		Interactive.setTileProperties(7, ANY); // Darkstone Middle
		Interactive.setTileProperties(8, ANY); // Darkstone Right
		Interactive.setTileProperties(9, ANY); // Darkstone Bottom
		
		// Add Tiles
		add(Foreground);
		add(Interactive);
		add(Background);
		add(PoleTiles);

		// Add Tux
		tux = new Tux();
		map.loadEntities(placeEntities, "entities");
		add(tux);

		// Make camera follow Tux
		FlxG.camera.follow(tux, PLATFORMER, 1);
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(tux, Interactive);
		super.update(elapsed);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "tux")
		{
			tux.setPosition(entity.x, entity.y);
		}
	}
}
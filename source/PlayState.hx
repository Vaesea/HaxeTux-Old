package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;

// TODO: Add a way for the player to NOT fall off the edge of the level.

class PlayState extends FlxState
{
	// You probably shouldn't change these if you're modding.
	var background:FlxBackdrop;
	var tux:Tux;
	var map:FlxOgmo3Loader;
	var levelBounds:FlxGroup; // temporary

	// Changing these is alright if you wanna do something like removing a layer or adding a layer.
	var Foreground:FlxTilemap;
	var Interactive:FlxTilemap;
	var Background:FlxTilemap;
	var PoleTiles:FlxTilemap;

	var levelNameText:FlxText;

	override public function create() // im so tired i cant do this properly today
	{
		super.create();
		createLevel(null, null, null, null);
	}

	function createLevel(levelBackground:String, levelJson:String, song:String, levelName:String)
	{
		super.create();
		
		// used a watermark thing i found in my cancelled fnf psych fork
		// Level Name text.
		levelNameText = new FlxText(0, 0, 640, levelName, 14);
		levelNameText.setFormat(null, 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		levelNameText.scrollFactor.set();
		levelNameText.borderSize = 1.25;
		
		background = new FlxBackdrop(levelBackground, X); // Change this if you want to change the background.
		background.scrollFactor.x = 0.1;
		background.scrollFactor.y = 0.1;

		map = new FlxOgmo3Loader('assets/data/haxetux.ogmo', levelJson);
		Foreground = map.loadTilemap('assets/images/normalTiles.png', 'Foreground');
		Interactive = map.loadTilemap('assets/images/normalTiles.png', 'Interactive');
		Background = map.loadTilemap('assets/images/normalTiles.png', 'Background');
		PoleTiles = map.loadTilemap('assets/images/poleTiles.png', 'PoleTiles');
		Interactive.follow();

		// Only touch if you've added new tiles.
		Interactive.setTileProperties(1, ANY); // Snow Left
		Interactive.setTileProperties(2, ANY); // Snow Middle
		Interactive.setTileProperties(3, ANY); // Snow Right
		Interactive.setTileProperties(4, ANY); // Snow Bottom
		Interactive.setTileProperties(6, ANY); // Darkstone Left
		Interactive.setTileProperties(7, ANY); // Darkstone Middle
		Interactive.setTileProperties(8, ANY); // Darkstone Right
		Interactive.setTileProperties(9, ANY); // Darkstone Bottom

		// Add Background
		add(background);
		
		// Add Tiles, further down on the list means it's visible on top of the others.
		add(PoleTiles);
		add(Background);
		add(Interactive);
		add(Foreground);

		// Add Tux
		tux = new Tux();
		map.loadEntities(placeEntities, "entities");
		add(tux);

		// Make camera follow Tux
		FlxG.camera.follow(tux, PLATFORMER, 1);
	
		// Play music
		FlxG.sound.playMusic(song);

		add(levelNameText);
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
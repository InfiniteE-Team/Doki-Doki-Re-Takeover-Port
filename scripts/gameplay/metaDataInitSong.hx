import flixel.text.FlxTextBorderStyle;

var metaName:Null<FlxText> = null;
var metaIcon:Null<FunkinSprite> = null;
var metaArtist:Null<FlxText> = null;

function postInitSong() {
    tweenIn();
}

var songArtist:String = '???';

function createMetadata() {
	metaName = new FlxText(20.0, 15.0, 0.0, curSong, 36);
	metaName.setFormat(Paths.getPath('riffic.ttf', 'font'), 36, 0xFFFFFFFF, "right", FlxTextBorderStyle.OUTLINE, 0xFF000000);
	metaName.alpha = 0.0;
	metaName.x = FlxG.width - (metaName.width + 20.0);
	metaName.cameras = [camHUD];
	add(metaName);

	metaIcon = new FunkinSprite(0.0, 0.0, true);
	metaIcon.loadGraphic(Paths.getPath('game/hud/metadata/pen', 'image'));
	metaIcon.scale.set(0.35, 0.35);
	metaIcon.setPosition(FlxG.width - (metaName.width) - 120.0, 15.0 - (metaIcon.height / 2.0) + 16.0);
	metaIcon.alpha = 0.0;
	metaIcon.cameras = [camHUD];
	add(metaIcon);

	if (curSong == 'My Confession (Re-Takeover)')
		songArtist = 'Noichi';
	else if (curSong == 'Rain Clouds (Re-Takeover)')
		songArtist = 'Mochoco';

	metaArtist = new FlxText(38, 38, 0, songArtist, 20);
	metaArtist.setFormat(Paths.getPath('aller.ttf', 'font'), 20, 0xFFFFFFFF, "right", FlxTextBorderStyle.OUTLINE, 0xFF000000);
	metaArtist.alpha = 0.0;
	metaArtist.setPosition(FlxG.width - (metaArtist.width + 20.0), metaArtist.y);
	metaArtist.cameras = [camHUD];
	add(metaArtist);
}

function tweenIn() {
	if (metaName == null) {
		createMetadata();
	}

	FlxTween.tween(metaName, {alpha: 1.0, y: 20.0}, 0.4, {ease: FlxEase.quartInOut});
	FlxTween.tween(metaIcon, {alpha: 1.0, y: 20.0 - (metaIcon.height / 2.0) + 16.0}, 0.4, {ease: FlxEase.quartInOut});
	FlxTween.tween(metaArtist, {alpha: 1.0, y: 58.0}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.1});
}

function tweenOut() {
	if (metaName == null)
		return;

	FlxTween.tween(metaName, {alpha: 0.0, y: 0.0}, 0.4, {ease: FlxEase.quartInOut});
	FlxTween.tween(metaIcon, {alpha: 0.0, y: 0.0 - (metaIcon.height / 2.0) + 16.0}, 0.4, {ease: FlxEase.quartInOut});
	FlxTween.tween(metaArtist, {alpha: 0.0, y: 38.0}, 0.4, {ease: FlxEase.quartInOut, onComplete: cleanUp});
}

function cleanUp():Void {
	metaName?.kill();
	metaName = null;
	metaIcon?.kill();
	metaIcon = null;
	metaArtist?.kill();
	metaArtist = null;
}

function onDestroy() {
	cleanUp();
}

function onStepHit(step:Int) {
    switch(step) {
        case 48:
            tweenOut();
    }
}

import flixel.util.FlxColor;

var note:FunkinSprite;
var noteTween:FlxTween;
final NOTE_X:Float = 120;
final TWEEN_LENGTH:Float = 0.7;

function onCreate() {
	note = new FunkinSprite(0, 150, true);
	note.frames = Paths.getPath('game/stages/clubRoom/events/notes', 'animated');
	note.addAnim('sayo', 'SayoNote', 24);
	note.addAnim('bf', 'BFNote', 24);
	note.addAnim('cow', 'CowNote', 24);
	note.addAnim('gf', 'GFNote', 24);
	note.playAnim('sayo');
	note.cameras = [camHUD];
	note.visible = false;
	add(note);
}

function postCreate() {
	cameraController.defaultZoom = 1.2;
	cameraController.moveCameraTo(0, 0);

	cameraController.isLock = true;
}

var black:FlxSprite;

function onCountdown() {
	black = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
	black.scrollFactor.set();
	black.screenCenter();
	add(black);
}

function onNote(isAppear:Bool, ?anim:String) {
	if (anim != null)
		note.playAnim(anim, true);
	var isLeft:Bool = note.animation.curAnim.name == 'bf' || note.animation.curAnim.name == 'gf';
	if (noteTween != null)
		noteTween.cancel();
	if (isAppear) {
		note.visible = true;
		note.x = isLeft ? -(100 + note.width) : (FlxG.width + 100);
		noteTween = FlxTween.tween(note, {x: isLeft ? NOTE_X : (FlxG.width - note.width - NOTE_X)}, TWEEN_LENGTH, {
			ease: FlxEase.circOut
		});
	} else {
		noteTween = FlxTween.tween(note, {x: isLeft ? -(100 + note.width) : (FlxG.width + 100)}, TWEEN_LENGTH, {
			ease: FlxEase.circOut,
			onComplete: function(twn:FlxTween) {
				note.visible = false;
			}
		});
	}
}

function onStepHit(step:Int) {
	switch (step) {
		case 1:
			FlxTween.tween(black, {alpha: 0}, 1, {ease: FlxEase.circOut});
			FlxTween.tween(cameraController.camPoint, {x: -120, y: 500}, 1, {ease: FlxEase.cubeInOut});
		case 13:
			cameraController.snapCameraTo(2200, 600);
		case 15:
			FlxTween.tween(cameraController.camPoint, {x: 2200 - 120, y: 100}, 1, {ease: FlxEase.cubeInOut});
		case 30:
			cameraController.snapCameraTo(1200, -200);
		case 32:
			FlxTween.tween(cameraController.camPoint, {y: 50}, 1, {ease: FlxEase.cubeInOut});
		case 40:
			FlxTween.tween(cameraController.camPoint, {y: 500}, 2, {ease: FlxEase.cubeInOut});
			FlxTween.tween(cameraController, {defaultZoom: 0.9}, 1.2);
		case 64:
			cameraController.isLock = false;
		case 256:
			cameraController.moveCameraTo(1100, 410);
			cameraController.defaultZoom = 0.8;
			cameraController.isLock = true;
		case 289:
			cameraController.isLock = false;
			cameraController.defaultZoom = 0.9;
		case 292:
			cameraController.isLock = true;
			cameraController.snapCameraTo(1300, 500);
		case 295:
			cameraController.defaultZoom = 0.82;
		case 302:
			cameraController.moveCameraTo(1100, 410);
			cameraController.defaultZoom = 0.7;
			cameraController.isLock = true;
		case 318:
			cameraController.isLock = false;
		case 322:
			onNote(true, 'sayo');
		case 350:
			onNote(false);
		case 356:
			onNote(true, 'bf');
		case 380:
			onNote(false);
		case 386:
			onNote(true, 'cow');
		case 414:
			onNote(false);
		case 420:
			onNote(true, 'gf');
		case 448:
			onNote(false);
		case 672:
			cameraController.defaultZoom = 0.82;
			FlxTween.tween(cameraController, {defaultZoom: 1.0}, 2.2, {ease: FlxEase.cubeInOut});
		case 701:
			cameraController.isLock = true;
			FlxTween.tween(cameraController, {defaultZoom: 0.53}, 4, {ease: FlxEase.cubeInOut});
			FlxTween.tween(cameraController.camPoint, {x: 1100, y: 410}, 4, {ease: FlxEase.cubeInOut});
	}
}

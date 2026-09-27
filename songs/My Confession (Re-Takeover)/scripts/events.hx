import flixel.group.FlxGroup.FlxTypedGroup;

var funnybubbles:Bool = false;
var particleGroup:FlxTypedGroup<FunkinSprite>;

function postCreate() {
	cameraController.defaultZoom = 0.53;
	cameraController.moveCameraTo(cameraController.camPoint.x + 1100, cameraController.camPoint.y + 410);
	cameraController.isLock = true;

	if (particleGroup == null) {
		particleGroup = new FlxTypedGroup();
		add(particleGroup);
	}
}

function spawnBubbles() {
	var scale:Float = FlxG.random.float(0.5, 0.745);

	var parti:FunkinSprite = new FunkinSprite(FlxG.random.int(-200, 3000), 1000, true);
	parti.loadGraphic(Paths.getPath('game/stages/clubRoom/events/bubble', 'image'));
	parti.scale.set(scale, scale);
	particleGroup.add(parti);

	FlxTween.tween(parti, {y: parti.y - 2000, alpha: 0}, FlxG.random.float(12, 23), {
		onComplete: function(tween:FlxTween) {
			parti?.kill();
			parti = null;
		}
	});
}

function onStepHit(step:Int) {
	if (funnybubbles && step % 2 == 0)
		spawnBubbles();

	switch (step) {
		case 48:
			FlxTween.tween(cameraController, {defaultZoom: 0.9}, 2);
		case 56:
			cameraController.isLock = false;
		case 193:
			cameraController.moveCameraTo(1100, 410);
			cameraController.defaultZoom = 0.82;
			cameraController.isLock = true;
		case 319:
			cameraController.defaultZoom = 0.86;
			cameraController.isLock = false;
		case 500:
			cameraController.defaultZoom = 0.76;
			cameraController.moveCameraTo(1100, 410);
			cameraController.isLock = true;
		case 577:
			cameraController.defaultZoom = 0.8;
		case 591:
			cameraController.defaultZoom = 0.82;
		case 592:
			chars.playSpecialAnim('gf-redoki', 'countdownThree');
			cameraController.moveCameraTo(cameraController.camPoint.x, cameraController.camPoint.y);
			cameraController.defaultZoom = 0.9;
		case 596:
			chars.playSpecialAnim('gf-redoki', 'countdownTwo');
			cameraController.defaultZoom = 1.0;
		case 600:
			chars.playSpecialAnim('gf-redoki', 'countdownOne');
		case 604:
			chars.playSpecialAnim('gf-redoki', 'countdownGo');
			cameraController.defaultZoom = 0.82;
			cameraController.isLock = false;
		case 630:
			funnybubbles = true;
		case 864:
            funnybubbles = false;
			endBubblesFast();
        case 1130:
            cameraController.moveCameraTo(1100, 410);
			cameraController.isLock = true;
			cameraController.defaultZoom = 0.8;
        case 1280:
			FlxTween.tween(cameraController, {defaultZoom: 0.53}, 6);
        case 1392:
			FlxTween.tween(cameraController, {defaultZoom: 0.9}, 1.2, {ease: FlxEase.cubeInOut});
	}
}

function onResume():Void {
	FlxTween.globalManager.forEach((tween:FlxTween) -> {
		if (!tween.active) {
			tween.active = true;
		}
	});
}

function onPause():Void {
	FlxTween.globalManager.forEach((tween:FlxTween) -> {
		if (tween.active) {
			tween.active = false;
		}
	});
}

function onDestroy():Void {
	funnybubbles = false;
	endBubblesFast();
	particleGroup = null;
}

function endBubblesFast() {
	if (particleGroup == null)
		return;

	for (particle in particleGroup) {
		if (particle != null) {
			FlxTween.cancelTweensOf(particle);
			particle?.kill();
			particleGroup.remove(particle);
			particle = null;
		}
	}
}
